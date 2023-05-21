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
    let price: String
    let image: String
    let category: String
   
    init(id: Int, name: String, price: String, image: String, category: String) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        self.category = category
    }
}
