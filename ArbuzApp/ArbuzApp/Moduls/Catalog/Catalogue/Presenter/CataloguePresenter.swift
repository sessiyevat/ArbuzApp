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
    var categoryProducts: [String : [Product]]?
    
    init(view: CatalogueViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        categoryProducts = groupByCategory()
        view?.update(products: categoryProducts)
    }
    
    func groupByCategory() -> [String : [Product]]? {
        let grouped = Dictionary(grouping: ProductList.products, by: { $0.category })
        return grouped
    }
    
    func getModel(by indexPath: IndexPath) -> Product {
        let continent = categoryProducts!.keys.sorted()[indexPath.section]
        let countriesForContinent = categoryProducts![continent]
        let countryModel = (countriesForContinent?[indexPath.row])!
        return countryModel
    }
    
    func cellTappedAt(_ indexPath: IndexPath){
        view?.showProductDetails(product: getModel(by: indexPath))
    }
}
