//
//  SectionHeader.swift
//  ArbuzApp
//
//  Created by Tommy on 5/20/23.
//

import UIKit
import SnapKit

class SectionHeader: UICollectionReusableView {
    
     static let identifier = "SectionHeader"
    
    // MARK: - UI Component
    
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .secondaryLabel
         label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
         label.sizeToFit()
         return label
     }()
    
    // MARK: - Lifecycle

     override init(frame: CGRect) {
         super.init(frame: frame)

         setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        addSubview(label)

        label.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}
