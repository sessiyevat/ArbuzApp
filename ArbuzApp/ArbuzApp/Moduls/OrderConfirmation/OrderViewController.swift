//
//  OrderViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/22/23.
//

import UIKit
import SnapKit

protocol OrderViewProtocol: UIViewController {
    func updateAddressInfo(address: String)
}

class OrderViewController: UIViewController, OrderViewProtocol {
    
    var presenter: OrderViewPresenterProtocol!
    
    // MARK: UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ваше имя"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Номер телефона"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private let deliveryTextLabel = UILabel()
    private let dateTextLabel = UILabel()
    private let timeTextLabel = UILabel()
    private let paymentTextLabel = UILabel()
    private let summaryTextLabel = UILabel()
    
    private let deliveryLabel: UILabel = {
       let label = UILabel()
        label.text = "Выбрать адрес"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let summaryLabel: UILabel = {
       let label = UILabel()
        label.text = "190190"
        label.font = .systemFont(ofSize: 26, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let cashPaymentButton = UIButton()
    private let cardPaymentButton = UIButton()
    
    private let dateScrollView = UIScrollView()
    private let dateContentView = UIView()
    
    private let timeScrollView = UIScrollView()
    private let timeContentView = UIView()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить заказ", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.isEnabled = true
        button.backgroundColor = UIColor(named: "main")
        return button
    }()
    
    var isPaymentSelected = false
    var isDateSelected = false
    var isTimeSelected = false
    
    var deliveryDate: String?
    var deliveryTime: String?
    var payment: String?
    
    var isDateTapped = false
    var isTimeTapped = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureConstraints()
        tappableAddressLabel()
    
        cashPaymentButton.addTarget(self, action: #selector(paymentButtonTapped(_:)), for: .touchUpInside)
        cardPaymentButton.addTarget(self, action: #selector(paymentButtonTapped(_:)), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.showsVerticalScrollIndicator = false
        
        dateScrollView.contentSize = CGSize(width: 880, height: 40)
        dateScrollView.showsHorizontalScrollIndicator = false
        
        timeScrollView.contentSize = CGSize(width: 880, height: 40)
        timeScrollView.showsHorizontalScrollIndicator = false
    }
    
    func updateAddressInfo(address: String) {
        deliveryLabel.text = address
    }
    
    @objc func orderButtonTapped() {
        if isValid() {
            let orderData = [nameTextField.text, phoneTextField.text, deliveryLabel.text, deliveryDate, deliveryTime, payment, summaryLabel.text]
            let vc = CompleteViewController(orderData: orderData)
            self.present(vc, animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func paymentButtonTapped(_ button: UIButton) {
        button.backgroundColor = UIColor(named: "main")
        button.setTitleColor(.white, for: .normal)
        isPaymentSelected = true
        payment = button.currentTitle
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Оформление"
        
        ([deliveryTextLabel, dateTextLabel, timeTextLabel, paymentTextLabel, summaryTextLabel]).forEach {
            contentView.addSubview($0)
            $0.font = .systemFont(ofSize: 22, weight: .semibold)
        }
        
        deliveryTextLabel.text = "Доставка"
        dateTextLabel.text = "Дата доставки"
        timeTextLabel.text = "Время доставки"
        paymentTextLabel.text = "Оплата"
        cashPaymentButton.setTitle("Наличными курьеру", for: .normal)
        cardPaymentButton.setTitle("Картой", for: .normal)
        summaryTextLabel.text = "Сумма к оплате"
        summaryLabel.text = String(presenter.getSummaryPayment())
        
        ([cashPaymentButton, cardPaymentButton]).forEach {
            contentView.addSubview($0)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
            $0.setTitleColor(UIColor(named: "main")?.withAlphaComponent(0.5), for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "main")?.withAlphaComponent(0.5).cgColor
        }
        
        view.addSubview(scrollView)
        scrollView.isUserInteractionEnabled = true
        scrollView.delaysContentTouches = false

        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        contentView.addSubview(nameTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(dateScrollView)
        
        createScrollingDates()
        
        contentView.addSubview(timeScrollView)
        createScrollingTimes()
        
        contentView.addSubview(summaryLabel)
        contentView.addSubview(orderButton)
        contentView.bringSubviewToFront(orderButton)
    }

    // MARK: Validation for fields
    
    private func isValid() -> Bool {
        var valid = true
        ([nameTextField.text, phoneTextField.text]).forEach {
            if ($0 ?? "").isEmpty {
                showAlert(with: "Введите все поля")
                valid = false
            }
        }
        if !valid { return false }

        if let number = phoneTextField.text {
            if !validateFieldNumber(num: number) {
                showAlert(with: "Номер телефона должен содержать только цифры.")
                return false
            }
        }

        if !validateField(string: nameTextField.text ?? "") {
            showAlert(with: "Имя должно содержать только буквы.")
            return false
        }
        
        if !isDateSelected {
            showAlert(with: "Дата доставки не выбрана")
            return false
        }
        
        if !isTimeSelected {
            showAlert(with: "Время доставки не выбрана")
            return false
        }

        if !isPaymentSelected {
            showAlert(with: "Способ оплаты не выбран")
            return false
        }

        return true
    }
    
    private func validateField(string: String) -> Bool {
        let validationFormat = "[a-zA-Z\\s]+"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: string)
    }
   
    private func validateFieldNumber(num: String) -> Bool {
        if let _ = Int(num) {
            return true
        } else {
            return false
        }
    }
   
    func showAlert(with text: String, message: String = "") {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createScrollingDates() {
        
        dateScrollView.isScrollEnabled = true
        dateScrollView.isUserInteractionEnabled = true
        dateScrollView.isPagingEnabled = false
        
        dateScrollView.addSubview(dateContentView)
        
        dateScrollView.snp.makeConstraints { make in
            make.top.equalTo(dateTextLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }
        
        dateContentView.snp.makeConstraints { make in
            make.left.right.equalTo(self.dateScrollView)
            make.width.height.top.bottom.equalTo(self.dateScrollView)
        }
        
        let calendar = Calendar.current
        var currentDate = calendar.startOfDay(for: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"

        var previousLabel: UILabel?
        for _ in 0...6 {
            let label = UILabel()
            label.text = dateFormatter.string(from: currentDate)
            
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dateLabelTapped(_:)))
            label.addGestureRecognizer(tapGesture)
            
            makeConstraintsForLabels(label, previousLabel, dateScrollView, dateContentView)
    
            previousLabel = label
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        previousLabel?.snp.makeConstraints { make in
            make.trailing.equalTo(dateScrollView.snp.trailing).inset(-20)
        }
    }
    
    @objc func dateLabelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel {
            if isDateTapped {
                label.backgroundColor = UIColor.white
            } else {
                label.backgroundColor = UIColor(named: "main")
                label.layer.cornerRadius = 10
                deliveryDate = label.text
            }
            isDateTapped.toggle()
        }
        
        isDateSelected = true
    }
    
    @objc func timeLabelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel {
            if isTimeTapped {
                label.backgroundColor = UIColor.white
            } else {
                label.backgroundColor = UIColor(named: "main")
                label.layer.cornerRadius = 10
                deliveryTime = label.text
            }
            isTimeTapped.toggle()
        }
        
        isTimeSelected = true
    }
    
    func createScrollingTimes() {
        
        let times = ["7:00", "9:00", "11:00", "13:00", "15:00", "17:00", "19:00"]
        
        timeScrollView.isScrollEnabled = true
        timeScrollView.isUserInteractionEnabled = true
        timeScrollView.isPagingEnabled = false
        
        timeScrollView.addSubview(timeContentView)
        
        timeScrollView.snp.makeConstraints { make in
            make.top.equalTo(timeTextLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }
        
        timeContentView.snp.makeConstraints { make in
            make.left.right.equalTo(self.timeScrollView)
            make.width.height.top.bottom.equalTo(self.timeScrollView)
        }

        var previousLabel: UILabel?
        for time in times {
            let label = UILabel()
            label.text = time
            
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(timeLabelTapped(_:)))
            label.addGestureRecognizer(tapGesture)
            
            makeConstraintsForLabels(label, previousLabel, timeScrollView, timeContentView)
            
            previousLabel = label
        }
        
        previousLabel?.snp.makeConstraints { make in
            make.trailing.equalTo(timeScrollView.snp.trailing).inset(-20)
        }
    }
    
    func makeConstraintsForLabels(_ label: UILabel, _ previousLabel: UILabel?, _ scrollView: UIScrollView, _ contentView: UIView){
        contentView.addSubview(label)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(named: "main")?.withAlphaComponent(0.5).cgColor
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.isUserInteractionEnabled = true
        
        label.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        if let previousLabel = previousLabel {
            label.snp.makeConstraints { make in
                make.leading.equalTo(previousLabel.snp.trailing).inset(-10)
            }
        } else {
            label.snp.makeConstraints { make in
                make.leading.equalTo(scrollView.snp.leading).inset(20)
            }
        }
    }
        
    func configureConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.centerX.centerY.equalTo(self.view)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.width.height.top.equalTo(self.scrollView)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).inset(10)
            make.height.equalTo(50)
        }
        
        ([nameTextField, phoneTextField, deliveryTextLabel, deliveryLabel, dateTextLabel, timeTextLabel, paymentTextLabel, summaryTextLabel, summaryLabel, orderButton]).forEach {
            $0.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.left).inset(20)
                make.right.equalTo(contentView.snp.right).inset(20)
            }
        }
        
        let labels = [phoneTextField, deliveryTextLabel, deliveryLabel, dateTextLabel, dateScrollView, timeTextLabel, timeScrollView]
        
        for (index, label) in labels.enumerated() {
            if index == 0 {
                label.snp.makeConstraints { make in
                    make.top.equalTo(nameTextField.snp.bottom).offset(10)
                    make.height.equalTo(50)
                }
                continue
            }
            
            label.snp.makeConstraints { make in
                make.top.equalTo(labels[index - 1].snp.bottom).offset(20)
            }
        }
   
        paymentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(timeScrollView.snp.bottom).offset(20)
        }
        
        cashPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(paymentTextLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
            make.trailing.equalTo(cardPaymentButton.snp.leading).offset(-10)
            make.left.equalTo(contentView.snp.left).inset(20)
        }
        
        cardPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(paymentTextLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.right.equalTo(contentView.snp.right).inset(20)
        }
        
        summaryTextLabel.snp.makeConstraints { make in
            make.top.equalTo(cashPaymentButton.snp.bottom).offset(20)
        }
        
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryTextLabel.snp.bottom).offset(20)
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    func tappableAddressLabel() {
        deliveryLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(openOverlayView))
        deliveryLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func openOverlayView() {
        let deliveryInfoView = DeliveryInfoView()
        deliveryInfoView.presenter = presenter
        
        deliveryInfoView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 250, width: UIScreen.main.bounds.width, height: 0)
        
        if let window = UIApplication.shared.keyWindow {
            deliveryInfoView.backgroundColor = UIColor(named: "customWhite")
            
            UIView.animate(withDuration: 0.1) {
                deliveryInfoView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 250, width: UIScreen.main.bounds.width, height: 400)
            }
            
            window.addSubview(deliveryInfoView)
            window.bringSubviewToFront(deliveryInfoView)
        }
    }
}

