//
//  ResetView.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit

class ResetView: UIView {
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Мы отправили код на ваш email"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var codeField: TextField = {
        let field = TextField()
        field.placeholder = "Введите код"
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

extension ResetView {
    
    private func setupSubviews() {
        addSubviews(
            titleLabel,
            codeField,
            continueButton
        )
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(codeField.snp.top).offset(-42)
            make.left.right.equalToSuperview().inset(40)
        }
 
        codeField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.left.right.equalToSuperview().inset(30)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(codeField.snp.bottom).offset(44)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
    }
}
