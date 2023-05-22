//
//  BucketViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import UIKit
import SnapKit

protocol BucketViewProtocol: UIViewController {
    func updateView(with products: [ProductItem])
}

class BucketViewController: UIViewController, BucketViewProtocol {
    
    // MARK: Variables

    private var products: [ProductItem] = [ProductItem]()
    var presenter: BucketPresenterProtocol!
    
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
        presenter.fetchLocalStorage()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        title = "Моя корзина"
        view.backgroundColor = .systemBackground
        view.addSubview(savedTable)
        
        savedTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func updateView(with products: [ProductItem]) {
        self.products = products
        DispatchQueue.main.async {
            self.savedTable.reloadData()
        }
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
                       price: String(product.price ?? ""),
                       imageName: product.imageName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            presenter.deleteFromStorage(indexPath)
            self.products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default: break;
        }
    }
}

