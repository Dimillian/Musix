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
    @IBOutlet weak var imageVie: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
