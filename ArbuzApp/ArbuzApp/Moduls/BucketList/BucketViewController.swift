//
//  BucketViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import UIKit

class BucketViewController: UIViewController {
    
    // MARK: Variables

    private var products: [ProductItem] = [ProductItem]()
    
    // MARK: - UI Components

    private let savedTable: UITableView = {
        let table = UITableView()
        table.register(BucketTableViewCell.self, forCellReuseIdentifier: BucketTableViewCell.identifier)
        return table
    } ()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        savedTable.delegate = self
        savedTable.dataSource = self
        
        fetchLocalStorage()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorage()
        }
    }
    
    func fetchLocalStorage(){
        DataManager.shared.fetchingProductsFromDB { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.savedTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - UI Setup

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedTable.frame = view.bounds
    }
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(savedTable)
    }
}

extension BucketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketTableViewCell.identifier, for: indexPath) as? BucketTableViewCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(name: product.name ?? "",
                       price: product.price ?? "",
                       imageName: product.imageName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataManager.shared.deleteTitleWith(model: products[indexPath.row]) { [weak self] result in
                switch result {
                case .success(): print("Deleted")
                case .failure(let error): print(error.localizedDescription)
                }
                
                self?.products.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default: break;
        }
    }
}

