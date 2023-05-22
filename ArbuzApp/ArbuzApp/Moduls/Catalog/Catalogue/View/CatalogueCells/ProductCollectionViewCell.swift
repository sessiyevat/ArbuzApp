//
//  ProductCollectionViewCell.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import UIKit
import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    // MARK: - UI Components
    
    private var productImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "template")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let productWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "kg"
        label.textColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "289 tg"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "customWhite")
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productWeightLabel)
        contentView.addSubview(priceLabel)
        
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(80)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(productImageView.snp.bottom).offset(10)
        }
        
        productWeightLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(productWeightLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(with product: Product){
        productImageView.image = UIImage(named: product.image)
        productNameLabel.text = product.name
        productWeightLabel.text = product.count
        priceLabel.text = String(product.price) + " ₸"
    }
}
