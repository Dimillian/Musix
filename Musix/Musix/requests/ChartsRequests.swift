//
//  ChartsRequests.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation
import ReSwift

struct GetCharts: Action {
    init() {
        GETRequest(path: "catalog/us/charts",
                   params: ["types": "albums,songs" as AnyObject,
                            "limit": 50 as AnyObject,
                            "offset": 0 as AnyObject]).start { (response: APIResponse<Chart>) in
            store.dispatch(SetCharts(chart: response.object))
        }
    }
}
