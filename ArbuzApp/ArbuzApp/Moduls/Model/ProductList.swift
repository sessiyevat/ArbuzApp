//
//  ProductList.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import Foundation

class ProductList {
    
    static var products: [Product] = [
        Product(id: 1, name: "Йогурт Danone питьевой клубника-овес-орехи 2.5% 270 г", price: 405, image: "milk1", category: "Молочные продукты", count: "шт"),
        Product(id: 2, name: "Молоко Новый День 1,5% 1 л", price: 655, image: "milk2", category: "Молочные продукты", count: "шт"),
        Product(id: 3, name: "Коктейль Растишка молочный Бабл-Гам 2% 210 г", price: 440, image: "milk3", category: "Молочные продукты", count: "шт"),
        Product(id: 4, name: "Сметана President 15%", price: 855, image: "milk4", category: "Молочные продукты", count: "кг"),
        
        Product(id: 5, name: "Клубника Вивара 400 г", price: 2460 , image: "fruit1", category: "Фрукты", count: "кг"),
        Product(id: 6, name: "Питахайя желтая", price: 19540 , image: "fruit2", category: "Фрукты", count: "кг"),
        Product(id: 7, name: "Бананы", price: 990, image: "fruit3", category: "Фрукты", count: "кг"),
        
        Product(id: 8, name: "Огурцы Рава", price: 410, image: "v1", category: "Овощи", count: "кг"),
        Product(id: 9, name: "Томаты на ветке", price: 655, image: "v2", category: "Овощи", count: "кг"),
        Product(id: 10, name: "Перец чили зеленый", price: 1625, image: "v3", category: "Овощи", count: "кг")
    ]
}
