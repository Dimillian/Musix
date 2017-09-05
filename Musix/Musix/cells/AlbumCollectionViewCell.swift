//
//  AlbumCollectionViewCell.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Cocoa
import SDWebImage

class AlbumCollectionViewCell: NSCollectionViewItem {

    static let id = "AlbumCollectionViewCell"
    
    @IBOutlet var titleLabel: NSTextFieldCell!
    @IBOutlet weak var authorLabel: NSTextFieldCell!
    @IBOutlet weak var coverView: NSImageView!

    var item: Item? {
        didSet {
            if let item = item, let attributes = item.attributes {
                titleLabel.title = attributes.artistName
                authorLabel.title = attributes.name
                let url = attributes.artwork.url.replacingOccurrences(of: "{w}",
                                                                      with: "500").replacingOccurrences(of: "{h}", with: "500")
                coverView.sd_setImage(with: URL(string: url))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        coverView.wantsLayer = true
        coverView.layer?.masksToBounds = false
        coverView.layer?.cornerRadius = 5
        coverView.layer?.borderWidth = 0.5
        coverView.layer?.borderColor = NSColor.lightGray.cgColor
    }
}
