//
//  BucketTableViewCell.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import UIKit
import SnapKit

class BucketTableViewCell: UITableViewCell {
    
    static let identifier = "BucketTableViewCell"
    var product: ProductItem?
    var counter = 1
    
    var presenter: BucketPresenterProtocol!
    
    // MARK: - UI Components
    
    private var productImageView: UIImageView = {
         let image = UIImageView()
         image.contentMode = .scaleAspectFit
         image.layer.masksToBounds = true
         return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "main")
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "main")
        return button
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "main")
        return button
    }()
    
    private let counterLabel: UILabel = {
       let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        decrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
    }
    
    @objc func decrementButtonTapped() {
        if let price = Int((product?.price)!) {
            let currPrice = price / counter
            self.counter -= 1
            if counter <= 0 {
                counter = 1
            } else {
                let sum = currPrice * counter
                priceLabel.text = String(sum) + " ₸"
                product?.price = String(sum)
                
            }
        }
        counterLabel.text = String(counter)
    }
        
    @objc func incrementButtonTapped() {
        self.counter += 1
        if let price = Int((product?.price)!) {
            let sum = price * counter
            priceLabel.text = String(sum) + " ₸"
            product?.price = String(sum)
        }
        counterLabel.text = String(counter)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI Setup

    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(incrementButton)
        contentView.addSubview(counterLabel)
        contentView.addSubview(decrementButton)
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing)
            make.top.equalTo(productImageView.snp.top).inset(-20)
            make.bottom.equalTo(priceLabel.snp.top)
            make.trailing.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing)
            make.bottom.equalToSuperview().inset(15)
        }
        
        decrementButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.top)
            make.leading.equalTo(priceLabel.snp.trailing)
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(15)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.leading.equalTo(decrementButton.snp.trailing)
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(15)
        }
        
        incrementButton.snp.makeConstraints { make in
            make.leading.equalTo(counterLabel.snp.trailing)
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(product: ProductItem) {
        self.product = product
        productImageView.image = UIImage(named: product.imageName!)
        nameLabel.text = product.name
        priceLabel.text = product.price! + " ₸"
    }
}
