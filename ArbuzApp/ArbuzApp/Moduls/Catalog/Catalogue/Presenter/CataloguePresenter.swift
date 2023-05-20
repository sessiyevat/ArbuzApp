//
//  ProuctsPresenter.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import Foundation
import UIKit

class CataloguePresenter: CataloguePresenterProtocol {
    
    weak var view: CatalogueViewProtocol?
//    var countries: [Country] = []
    
    init(view: CatalogueViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
    func cellTappedAt(product: String){
        view?.showProductDetails(product: "someString")
    }
    
//    private func updateTableView(viewModel: [CountriesListViewModel], continents: [String]) {
//        DispatchQueue.main.async { [weak self] in
//            self?.view?.updateCollectionView(viewModel: viewModel, continents: continents)
//        }
//    }

//    func learnMoreButtonTapped(viewModel: CountriesListViewModel){
//        view?.showCountryDetails(viewModel: viewModel)
//    }
}
