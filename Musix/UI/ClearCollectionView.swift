//
//  ClearCollectionView.swift
//  UI
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Cocoa

open class ClearCollectionView: NSCollectionView {

    override open var isOpaque: Bool {
        return false
    }

    override open var allowsVibrancy: Bool {
        return true
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColors = [.clear]
    }
}
