//
//  Category.swift
//  Todoey
//
//  Created by Megan Brown on 3/2/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()        // states that the children of this class is an array of type Item
                                   // a list is like an array from realm
}
