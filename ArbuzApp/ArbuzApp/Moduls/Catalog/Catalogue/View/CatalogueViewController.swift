//
//  CatalogViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/19/23.
//

import UIKit
import SnapKit

class CatalogueViewController: UIViewController, CatalogueViewProtocol {

    var presenter: CataloguePresenterProtocol!
    var products: [String : [Product]]?
    
    // MARK: - UI Components
    
    lazy private var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Искать на Арбузе"
       return searchBar
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-45)
            make.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview().inset(10)
        }
    }

    func update(products: [String : [Product]]?) {
        self.products = products
    }
    
    func showProductDetails(product: Product) {
        let vc = MainAssembly.createProductDetails(product: product)
        self.present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension CatalogueViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: let cell = PosterCollectionView()
            return cell
        case 1:
            let cell = CatalogueSectionsCollectionView()
            cell.presenter = presenter
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 750
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

