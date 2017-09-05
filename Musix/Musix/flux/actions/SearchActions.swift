//
//  SearchActions.swift
//  Musix
//
//  Created by Thomas Ricouard on 05/09/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

struct SetAlbumSearchResults: Action {
    let search: String
    let result: [Item]?
}
