//
//  ViewController.swift
//  Musix
//
//  Created by Thomas Ricouard on 30/06/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Cocoa
import ReSwift
import UI
import SDWebImage

class CollectionViewController: NSViewController {

    @IBOutlet var collectionView: ClearCollectionView!
    @IBOutlet var searchField: NSSearchField!
    
    let cellIdentifier = NSUserInterfaceItemIdentifier.init(AlbumCollectionViewCell.id)

    var datasource: [Item] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareCollectionView()

        store.subscribe(self)
        store.dispatch(GetCharts())
    }

    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.enclosingScrollView?.autohidesScrollers = false
        collectionView.allowsMultipleSelection = false
        collectionView.isSelectable = true

        let nib = NSNib(nibNamed: NSNib.Name.init("AlbumCollectionViewCell"), bundle: nil)!
        collectionView.register(nib, forItemWithIdentifier: cellIdentifier)

        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 150, height: 200)
        flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
    }
}

extension CollectionViewController: StoreSubscriber {
    func newState(state: AppState) {
        if !searchField.stringValue.isEmpty, let results = state.searchState.searchsResult[searchField.stringValue] {
            DispatchQueue.main.async {
                self.datasource = results
            }
        } else if let chart = state.chartsState.chartResults, let albums = chart.results["albums"], let list = albums.first {
            DispatchQueue.main.async {
                self.datasource = list.data
            }
        }
    }
}

extension CollectionViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        if let cell = collectionView.makeItem(withIdentifier: cellIdentifier,
                                              for: indexPath) as? AlbumCollectionViewCell {

            let album = datasource[indexPath.item]
            cell.item = album
            return cell
        }
        return NSCollectionViewItem()
    }

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let albumVC = storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AlbumViewController")) as! AlbumViewController
        let popover = NSPopover()
        popover.appearance = NSAppearance(appearanceNamed: .vibrantDark, bundle: Bundle.main)
        popover.contentSize = NSSize(width: 200, height: 300)
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = albumVC

        let cell = collectionView.dataSource!.collectionView(collectionView, itemForRepresentedObjectAt: indexPaths.first!)
        popover.show(relativeTo: cell.view.frame, of: collectionView, preferredEdge: .minY)
    }
}

extension CollectionViewController: NSSearchFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        if !searchField.stringValue.isEmpty {
            store.dispatch(GetSearchAlbums(search: searchField.stringValue))
        } else {
            store.dispatch(GetCharts())
        }
    }
}

