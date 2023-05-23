//
//  DeliveryView.swift
//  ArbuzApp
//
//  Created by Tommy on 5/23/23.
//

import UIKit
import SnapKit

class DeliveryInfoView: UIView {
    
    var presenter: OrderViewPresenterProtocol!
   
    private let streetTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Улица"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private let buildingTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Дом"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private let apartmentTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Квартира"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "main")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveButtonTapped() {
        if let street = streetTextField.text,
           let building = buildingTextField.text,
           let apartment = apartmentTextField.text {
            let address = street + ", " + building + ", " + apartment
            presenter.deliveryAddressInfo(address: address)
        }
        removeFromSuperview()
    }
    
    func setupUI() {
        addSubview(streetTextField)
        addSubview(buildingTextField)
        addSubview(apartmentTextField)
        addSubview(saveButton)
        
        streetTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        buildingTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(self).multipliedBy(0.5)
            make.leading.equalTo(self).inset(10)
            make.trailing.equalTo(apartmentTextField.snp.leading).offset(-10)
        }
        
        apartmentTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.trailing.equalTo(self).inset(10)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(buildingTextField.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(self).inset(10)
        }
    }
}
