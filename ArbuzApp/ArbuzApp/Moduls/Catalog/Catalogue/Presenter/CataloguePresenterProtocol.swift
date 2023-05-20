//
//  CataloguePresenterProtocol.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import Foundation

protocol CataloguePresenterProtocol {
    func viewDidLoad()
//    func learnMoreButtonTapped(viewModel: CountriesListViewModel)
    func cellTappedAt(product: String)
}
