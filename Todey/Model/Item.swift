//
//  Item.swift
//  Todey
//
//  Created by Vishal Methri on 21/07/24.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var isDone: Bool = false
    @Persisted var dateCreated: Date?
    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<Category>
//    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
