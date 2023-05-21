//
//  BucketTableViewCell.swift
//  ArbuzApp
//
//  Created by Tommy on 5/21/23.
//

import UIKit

class BucketTableViewCell: UITableViewCell {
    
    static let identifier = "BucketTableViewCell"
    
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
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "main")
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI Setup

    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(15)
            make.trailing.equalTo(nameLabel.snp.leading)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing)
            make.top.equalToSuperview().inset(15)
            make.bottom.equalTo(priceLabel.snp.top)
            make.trailing.equalToSuperview().inset(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(name: String, price: String, imageName: String) {
        productImageView.image = UIImage(named: imageName)
        nameLabel.text = name
        priceLabel.text = price
    }
}
