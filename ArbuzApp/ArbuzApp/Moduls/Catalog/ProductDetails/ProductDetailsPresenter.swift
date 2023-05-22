//
//  ProductDetailsPresenter.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import Foundation

protocol ProductDetailsPresenterProtocol {
    func viewDidLoad()
    func addToCart()
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    
    private weak var view: ProductDetailsViewProtocol?
    private var product: Product?
    
    init(view: ProductDetailsViewProtocol, product: Product) {
        self.view = view
        self.product = product
    }
    
    func viewDidLoad() {
        updateView(with: product!)
    }
    
    private func updateView(with product: Product) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateView(with: product)
        }
    }

    func addToCart() {
        DataManager.shared.downloadProduct(model: self.product!) { result in
            switch result{
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
