//
//  DataManager.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import Foundation
import UIKit
import CoreData

class DataManager{
    
    enum DataBaseError: Error{
        case failedToSave
    }
    
    static let shared = DataManager()
    
    func downloadProduct(model: Product, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = ProductItem(context: context)
        item.id = Int64(model.id)
        item.name = model.name
        item.price = model.price
        item.category = model.category
        item.imageName = model.image
        
        do{
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DataBaseError.failedToSave))
        }
    }
    
    func fetchingProductsFromDB(completion: @escaping (Result<[ProductItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<ProductItem>
        request = ProductItem.fetchRequest()
        
        do {
            let products = try context.fetch(request)
            completion(.success(products))
        } catch{
            completion(.failure(DataBaseError.failedToSave))
        }
    }
    
    func deleteTitleWith(model: ProductItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSave))
        }
    }
}
