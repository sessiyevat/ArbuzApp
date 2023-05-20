//
//  CatalogueViewProtocol.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import Foundation

import Foundation
import UIKit

protocol CatalogueViewProtocol: UIViewController {
//    func updateCollectionView(viewModel: [CountriesListViewModel], continents: [String])
//    func showCountryDetails(viewModel: CountriesListViewModel)
    func showProductDetails(product: String)
}
