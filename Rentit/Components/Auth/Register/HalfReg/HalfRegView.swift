//
//  HalfRegView.swift
//  Rentit
//
//  Created Eldiiar on 26/10/22.
//

import UIKit

class HalfRegView: UIView {
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "Пройдя частичную регистрацию, вы не сможете использовать  все функции Rent It - общаться с другими пользователями, оставлять отзывы, размещать объявления и многое другое."
        label.numberOfLines = 0
        label.font = R.font.commissionerRegular(size: 13)
        label.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        return label
    }()
    
    var surnameField: TextField = {
        let field = TextField()
        field.placeholder = "Фамилия"
        field.autocapitalizationType = .words
        return field
    }()
    
    var nameField: TextField = {
        let field = TextField()
        field.placeholder = "Имя"
        field.autocapitalizationType = .words
        return field
    }()
    
    lazy var phoneField: TextField = {
        let field = TextField()
        field.placeholder = "Номер телефона"
        return field
    }()
    
    lazy var passwordField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        return field
    }()
    
    lazy var repeatPasswordField: TextField = {
        let field = TextField()
        field.placeholder = "Повторить пароль"
        field.isSecureTextEntry = true
        return field
    }()
    
    lazy var continueButton: GrayishButton = {
        let button = GrayishButton()
        button.setTitle("Продолжить", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension HalfRegView {
    
    private func setupSubviews() {
        addSubviews(
            descLabel,
            surnameField,
            nameField,
            phoneField,
            passwordField,
            repeatPasswordField,
            continueButton
        )
    }
    
    private func setupConstraints() {
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(40)
        }
        
        surnameField.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(surnameField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        repeatPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordField.snp.bottom).inset(-50)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
    }
}
