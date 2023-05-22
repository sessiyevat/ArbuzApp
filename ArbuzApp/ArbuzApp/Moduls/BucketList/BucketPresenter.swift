//
//  BucketPresenter.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import Foundation

protocol BucketPresenterProtocol {
    func fetchLocalStorage()
    func deleteFromStorage(_ indexPath: IndexPath)
}

class BucketPresenter: BucketPresenterProtocol {
    
    private weak var view: BucketViewProtocol?
    private var products: [ProductItem]?
    
    init(view: BucketViewProtocol) {
        self.view = view
    }
    
    func fetchLocalStorage() {
        DataManager.shared.fetchingProductsFromDB { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.updateView(with: products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateView(with products: [ProductItem]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateView(with: products)
        }
    }
    
    func deleteFromStorage(_ indexPath: IndexPath) {
        DataManager.shared.deleteTitleWith(model: products![indexPath.row]) { [weak self] result in
            switch result {
            case .success(): print("Deleted")
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
