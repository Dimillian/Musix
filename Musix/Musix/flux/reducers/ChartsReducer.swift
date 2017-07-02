//
//  ChartsReducer.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

func chartsReducer(state: ChartsState?, action: Action) -> ChartsState {
    var state = state ?? ChartsState()
    switch action {
    case let action as SetCharts:
        state.chartResults = action.chart
    default:
        break
    }
    return state
}
