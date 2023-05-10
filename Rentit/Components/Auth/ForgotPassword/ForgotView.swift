//
//  ForgotView.swift
//  Rentit
//
//  Created Eldiiar on 8/11/22.
//

import UIKit

class ForgotView: UIView {
    
    lazy var emailField: TextField = {
        let field = TextField()
        field.placeholder = "Адрес электронной почты"
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

extension ForgotView {
    
    private func setupSubviews() {
        addSubviews(
            emailField,
            continueButton
        )
    }
    
    private func setupConstraints() {
        emailField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.left.right.equalToSuperview().inset(30)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(44)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
    }
}
