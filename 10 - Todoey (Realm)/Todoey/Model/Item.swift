//
//  Item.swift
//  Todoey
//
//  Created by Megan Brown on 3/2/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")    // child relationship
}
