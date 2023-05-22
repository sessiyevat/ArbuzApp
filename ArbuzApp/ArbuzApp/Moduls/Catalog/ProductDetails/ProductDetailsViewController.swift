//
//  ProductDetailsViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import UIKit
import SnapKit

class ProductDetailsViewController: UIViewController, ProductDetailsViewProtocol{
    
    // MARK: - Variables

    private var product: Product?
    var presenter: ProductDetailsPresenterProtocol!
    
    // MARK: - UI Components

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
       let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "main")
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.viewDidLoad()
    }
    
    func updateView(with product: Product) {
        self.product = product
        imageView.image = UIImage(named: product.image)
        productNameLabel.text = product.name
        priceLabel.text = String(product.price) + " ₸"
    }
    
    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(productNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(addButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.leading.equalToSuperview().inset(20)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.leading.equalTo(priceLabel.snp.trailing).offset(40)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(160)

        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        addButton.addTarget(self, action: #selector(AddToCart), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
    }
    
    @objc private func AddToCart() {
        presenter.addToCart()
        dismiss(animated: true, completion: nil)
    }
}
