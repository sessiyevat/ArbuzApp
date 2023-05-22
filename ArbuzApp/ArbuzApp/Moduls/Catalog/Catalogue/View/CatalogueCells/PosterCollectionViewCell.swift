//
//  PosterCollectionViewCell.swift
//  ArbuzApp
//
//  Created by Tommy on 5/22/23.
//

import UIKit
import SnapKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    // MARK: - UI Components
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
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
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    func configure(imageName: String){
        imageView.image = UIImage(named: imageName)
    }
}
