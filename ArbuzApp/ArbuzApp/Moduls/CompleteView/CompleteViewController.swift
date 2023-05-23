//
//  CompleteViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/23/23.
//

import UIKit
import SnapKit

class CompleteViewController: UIViewController {

    var data: [String?]
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark.circle")
        image.tintColor = UIColor(named: "main")
        return image
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let orderInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "main")
        return button
    }()
    
    init(orderData: [String?]) {
        data = orderData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let text = "Поздравляю, " + (data[0] ?? "") + ", ваш заказ оформлен!\n"
        let texts = [
            "Детали заказа:",
            "Номер телефона: \(data[1] ?? "")",
            "Адрес доставки: \(data[2] ?? "")",
            "Дата доставки: \(data[3] ?? ""), \(data[4] ?? "")",
            "Оплата: \(data[5] ?? "")",
            "Сумма заказа: \(data[6] ?? "")"
        ]

        let result = texts.joined(separator: "\n")
        mainLabel.text = text
        orderInfoLabel.text = result
        setupUI()
        
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    @objc func okButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func setupUI() {
        view.addSubview(imageView)
        view.addSubview(mainLabel)
        view.addSubview(orderInfoLabel)
        view.addSubview(okButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        orderInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(orderInfoLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
}
