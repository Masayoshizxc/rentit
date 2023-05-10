//
//  InfoTableViewCell.swift
//  Rentit
//
//  Created by Eldiiar on 11/11/22.
//

import UIKit

class InfoTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var address: (() -> Void)?
    var callback : ((String) -> Void)?
    var dataSource = [String]()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = R.font.commissionerMedium(size: 16)
        return label
    }()
    
    lazy var pullDownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выберите расположение", for: .normal)
        button.setTitleColor(R.color.grayish(), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapPullDown), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.isHidden = true
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        config.baseBackgroundColor = R.color.whiteGray()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = R.font.commissionerRegular(size: 14)
            return outgoing
        }
        button.configuration = config
        return button
    }()
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.backgroundColor = R.color.whiteGray()
        field.layer.cornerRadius = 5
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        field.font = R.font.commissionerRegular(size: 14)
        field.delegate = self
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        contentView.addSubviews(
            titleLabel,
            textField,
            pullDownButton
        )
                
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(type: String, title: String, value: [String]) {
        titleLabel.text = title
        if type == "select" {
            textField.isHidden = true
            pullDownButton.setTitle(title, for: .normal)
            pullDownButton.isHidden = false
            dataSource = value
        } else if type == "address" {
            textField.isHidden = true
            pullDownButton.setTitle(title, for: .normal)
            pullDownButton.isHidden = false
        } else {
            pullDownButton.isHidden = true
            textField.placeholder = title
        }
    }
    
    func setUpData(title: String, id: Int) {
        titleLabel.text = title
        textField.placeholder = title
        textField.tag = id
    }
    
    
    
    @objc func didTapPullDown() {
        address?()
    }
    

    func textFieldDidChangeSelection(_ textField: UITextField) {
        callback?(textField.text ?? "")
    }
    
    func setUpConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.left.equalToSuperview().inset(5)
        }
        
        pullDownButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
        
        textField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
    }

}
