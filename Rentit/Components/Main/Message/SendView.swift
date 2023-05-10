//
//  SendView.swift
//  Rentit
//
//  Created by Eldiiar on 26/11/22.
//

import UIKit

protocol SendProtocol {
    func didTapSendButton(value: String)
    func didTapInputButton()
}

class SendView: UIView {
    
    var delegate: SendProtocol? = nil
    
    private lazy var chooseButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.clip(), for: .normal)
        button.addTarget(self, action: #selector(didTapInputButton), for: .touchUpInside)
        return button
    }()
    
    lazy var messageField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите сообщение"
        field.layer.cornerRadius = 10
        field.backgroundColor = R.color.whiteGray()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        field.leftViewMode = .always
        field.delegate = self
        field.returnKeyType = .send
        return field
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.send(), for: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(
            chooseButton,
            messageField,
            sendButton
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapInputButton() {
        if delegate != nil {
            delegate?.didTapInputButton()
        }
    }
    
    @objc func didTapSendButton() {
        guard messageField.text != "" else { return }
        if delegate != nil {
            print("Message sent", messageField.text ?? "")
            delegate?.didTapSendButton(value: messageField.text ?? "")
            messageField.text = ""
        }
    }
    
    func setUpConstraints() {
        chooseButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18.5)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(24)
            make.bottom.equalToSuperview().inset(18.5)
        }
        
        messageField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalTo(chooseButton.snp.right).offset(10)
            make.right.equalTo(sendButton.snp.left).offset(-10)
            make.bottom.equalToSuperview().inset(12)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18.5)
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(24)
            make.bottom.equalToSuperview().inset(18.5)
        }
    }
}

extension SendView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSendButton()
        return true
    }
}
