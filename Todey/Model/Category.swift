//
//  Category.swift
//  Todey
//
//  Created by Vishal Methri on 21/07/24.
//

import Foundation
import RealmSwift

class Category : Object {
    @Persisted var name: String = ""
    @Persisted var items = List<Item>()
    
}
