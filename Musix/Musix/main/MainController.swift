//
//  MainController.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

let store = Store<AppState>(reducer: AppReducer,
                            state: nil,
                            middleware: [])

class MainController {
    static let shared = MainController()

    init() {

    }

    func initialConfiguration() {
        
    }
}
