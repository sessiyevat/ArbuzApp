//
//  Product.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import Foundation

class Product {
    let id: Int
    let name: String
    let price: Int
    let image: String
    let category: String
    let count: String
   
    init(id: Int, name: String, price: Int, image: String, category: String, count: String) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        self.category = category
        self.count = count
    }
}
