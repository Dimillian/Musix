//
//  Item.swift
//  Musix
//
//  Created by Thomas Ricouard on 02/07/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Foundation

class Item: Codable {
    var attributes: Attributes?
}

class Attributes: Codable {
    var artistName: String!
    var name: String!
    var artwork: Artwork!
}

class Artwork: Codable  {
    var url: String!
}
