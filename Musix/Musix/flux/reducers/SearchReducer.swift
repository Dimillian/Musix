//
//  SearchReducer.swift
//  Musix
//
//  Created by Thomas Ricouard on 05/09/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

func searchReducer(state: SearchState?, action: Action) -> SearchState {
    var state = state ?? SearchState()
    switch action {
    case let action as SetAlbumSearchResults:
        if let albums = action.result {
            state.searchsResult[action.search] = albums
        }
    default:
        break
    }
    return state
}

