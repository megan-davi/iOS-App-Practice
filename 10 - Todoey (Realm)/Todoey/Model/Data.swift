//
//  Data.swift
//  Todoey
//
//  Created by Megan Brown on 2/24/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc var age: Int = 0
}
