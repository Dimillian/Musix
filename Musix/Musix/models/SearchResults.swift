//
//  SearchResults.swift
//  Musix
//
//  Created by Thomas Ricouard on 05/09/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation

class SearchResults: Codable {
    var results: [String: AlbumResults]
}

class AlbumResults: Codable {
    var data: [Item]!
}
