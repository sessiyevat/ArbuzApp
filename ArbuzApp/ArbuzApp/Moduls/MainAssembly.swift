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
}
