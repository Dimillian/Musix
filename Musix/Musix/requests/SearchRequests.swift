//
//  SearchRequests.swift
//  Musix
//
//  Created by Thomas Ricouard on 05/09/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

struct GetSearchAlbums: Action {
    init(search: String) {
        let query = search.replacingOccurrences(of: " ", with: "+")
        GETRequest(path: "catalog/us/search",
                   params: ["term": query as AnyObject,
                            "types": "albums" as AnyObject,
                            "limit": 25 as AnyObject,
                            "offset": 0 as AnyObject]).start { (response: APIResponse<SearchResults>) in
                                if let albums = response.object?.results["albums"] {
                                    store.dispatch(SetAlbumSearchResults(search: search,
                                                                         result: albums.data))
                                }
        }
    }
}

