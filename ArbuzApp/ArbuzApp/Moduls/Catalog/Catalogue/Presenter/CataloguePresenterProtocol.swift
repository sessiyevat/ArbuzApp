//
//  CataloguePresenterProtocol.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import Foundation

protocol CataloguePresenterProtocol {
    var categoryProducts: [String : [Product]]? { get }
    
    func viewDidLoad()
//    func learnMoreButtonTapped(viewModel: CountriesListViewModel)
    func cellTappedAt(_ indexPath: IndexPath)
    func getModel(by indexPath: IndexPath) -> Product
//    func getModel()
}
