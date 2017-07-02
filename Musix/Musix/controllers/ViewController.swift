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

class ViewController: NSViewController {

    @IBOutlet var collectionView: ClearCollectionView!
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
        let nib = NSNib(nibNamed: NSNib.Name.init("AlbumCollectionViewCell"), bundle: nil)!
        collectionView.register(nib, forItemWithIdentifier: cellIdentifier)

        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 100, height: 100)
        flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        collectionView.collectionViewLayout = flowLayout
    }
}

extension ViewController: StoreSubscriber {
    func newState(state: AppState) {
        if let chart = state.chartsState.chartResults, let albums = chart.results["albums"], let list = albums.first {
            DispatchQueue.main.async {
                self.datasource = list.data
            }
        }
    }
}

extension ViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        if let item = collectionView.makeItem(withIdentifier: cellIdentifier,
                                              for: indexPath) as? AlbumCollectionViewCell {

            let album = datasource[indexPath.item]
            item.titleLabel.title = album.attributes!.artistName

            let url = album.attributes?.artwork.url.replacingOccurrences(of: "{w}", with: "500").replacingOccurrences(of: "{h}", with: "500")
            item.imageVie.sd_setImage(with: URL(string: url!))
            return item
        }
        return NSCollectionViewItem()
    }
}

