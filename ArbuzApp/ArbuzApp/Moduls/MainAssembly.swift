//
//  MainAssembly.swift
//  ArbuzApp
//
//  Created by Tommy on 5/19/23.
//

import Foundation

class MainAssembly {
    
    static func createTabBar() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }
    
    static func createCatalogue() -> CatalogueViewController {
        let viewController = CatalogueViewController()
        
        let presenter = CataloguePresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
    
    static func createProductDetails(product: Product) -> ProductDetailsViewController {
        let viewController = ProductDetailsViewController()
        let presenter = ProductDetailsPresenter(view: viewController, product: product)
        viewController.presenter = presenter
        
        return viewController
    }
    
    static func createBucket() -> BucketViewController {
        let viewController = BucketViewController()
        let presenter = BucketPresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
    
    static func createOrderView(_ products: [ProductItem]) -> OrderViewController {
        let viewController = OrderViewController()
        let presenter = OrderViewPresenter(view: viewController, products: products)
        viewController.presenter = presenter
        
        return viewController
    }
}
