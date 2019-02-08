//
//  Item.swift
//  Todoey
//
//  Created by Megan Brown on 1/31/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import UIKit

// Item class conforms to both Encodable and Decodable protocols using just "Codable"
class Item: Codable {
    var title = ""
    var done = false
}

