//
//  State.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var chartsState: ChartsState
    var searchState: SearchState
}

