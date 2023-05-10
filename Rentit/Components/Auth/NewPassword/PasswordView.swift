//
//  PasswordView.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit

class PasswordView: UIView {
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Введите новый пароль"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var passField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var repPassField: TextField = {
        let field = TextField()
        field.placeholder = "Подтвердите пароль"
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var continueButton: GrayishButton = {
        let button = GrayishButton()
        button.setTitle("Продолжить", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension PasswordView {
    
    private func setupSubviews() {
        addSubviews(
            titleLabel,
            passField,
            repPassField,
            continueButton
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(passField.snp.top).offset(-42)
            make.left.right.equalToSuperview().inset(40)
        }
        
        passField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.left.right.equalToSuperview().inset(30)
        }
        
        repPassField.snp.makeConstraints { make in
            make.top.equalTo(passField.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(repPassField.snp.bottom).offset(44)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
    }
}
