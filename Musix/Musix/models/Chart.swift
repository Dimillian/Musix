//
//  Chart.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation

class Chart: Codable {
    var results: [String: [Charts]]!
}

class Charts: Codable {
    var chart: String!
    var data: [Item]!
}
