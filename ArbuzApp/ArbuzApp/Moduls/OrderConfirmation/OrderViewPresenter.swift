//
//  OrderPresenter.swift
//  ArbuzApp
//
//  Created by Tommy on 5/23/23.
//

import Foundation

protocol OrderViewPresenterProtocol {
    func deliveryAddressInfo(address: String)
    func getSummaryPayment() -> Int
}

class OrderViewPresenter: OrderViewPresenterProtocol {
    private weak var view: OrderViewProtocol?
    private var products: [ProductItem]?
    
    init(view: OrderViewProtocol, products: [ProductItem]) {
        self.view = view
        self.products = products
    }
    
    func deliveryAddressInfo(address: String) {
        self.view?.updateAddressInfo(address: address)
    }
    
    func getSummaryPayment() -> Int {
        var sum = 0
        if let products = products {
            for item in products {
                if let price = item.price {
                    sum += Int(price)!
                }
            }
        }
        
        return sum
    }
}
