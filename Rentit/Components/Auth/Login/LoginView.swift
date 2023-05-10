//
//  AuthView.swift
//  Rentit
//
//  Created Eldiiar on 15/10/22.
//

import UIKit

class LoginView: UIView {
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "С возвращением!"
        label.font = R.font.commissionerMedium(size: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailField: TextField = {
        let field = TextField()
        field.placeholder = "Адрес электронной почты"
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var passwordField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        return field
    }()
    
    lazy var forgotPassword: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = R.font.commissionerMedium(size: 14)
        button.setTitleColor(R.color.forIcons(), for: .normal)
        return button
    }()
    
    lazy var loginButton: YellowButton = {
        let button = YellowButton()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "или войти через аккаунт:"
        label.font = R.font.commissionerRegular(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var metaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook", for: .normal)
        button.backgroundColor = .purple
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google", for: .normal)
        button.backgroundColor = .purple
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension LoginView {
    
    private func setupSubviews() {
        addSubviews(
            titleLabel,
            emailField,
            passwordField,
            forgotPassword,
            loginButton,
            descLabel
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(202)
            make.left.right.equalToSuperview().inset(65)
            make.height.equalTo(30)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-60)
            make.left.right.equalToSuperview().inset(40)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).inset(-30)
            make.left.right.equalToSuperview().inset(40)
        }
        
        forgotPassword.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(33)
            make.left.equalTo(passwordField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(105)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-93)
            make.left.right.equalToSuperview().inset(95)
        }
    }
}
