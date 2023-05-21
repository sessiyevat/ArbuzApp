//
//  ProductDetailsPresenter.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import Foundation

protocol ProductDetailsPresenterProtocol {
    func viewDidLoad()
//    func addCharacterToFavorites(character: CharacterDetailsViewModel)
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    
    private weak var view: ProductDetailsViewProtocol?
    private var product: Product?
    
    init(view: ProductDetailsViewProtocol, product: Product) {
        self.view = view
        self.product = product
    }
    
    func viewDidLoad() {
//        let viewModel = CharacterDetailsViewModel(character: character!)
//        updateView(with: viewModel)

    }
    
//    private func updateView(with viewModel: CharacterDetailsViewModel?) {
//        DispatchQueue.main.async { [weak self] in
//            self?.view?.updateView(with: viewModel)
//        }
//    }
//
//    func addCharacterToFavorites(character: CharacterDetailsViewModel) {
//        DataManager.shared.saveCharacter(character: character) { result in
//            switch result{
//            case .success():
//                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
