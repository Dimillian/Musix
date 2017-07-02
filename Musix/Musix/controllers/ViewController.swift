//
//  ViewController.swift
//  Musix
//
//  Created by Thomas Ricouard on 30/06/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Cocoa
import ReSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        store.dispatch(GetCharts())
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

