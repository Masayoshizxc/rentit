//
//  RentSubmitView.swift
//  Rentit
//
//  Created Eldiiar on 12/11/22.
//

import UIKit

class RentSubmitView: UIView {
    
    private lazy var titleLabel1 : UILabel = {
        let label = UILabel()
        label.text = "Арендная плата за сутки"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var rentField: BlueTextField = {
        let field = BlueTextField()
        field.placeholder = "Размер арендной платы"
        return field
    }()
    
    private lazy var somsButton1: UIButton = {
        let button = UIButton()
        button.setTitle("сомы", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = R.font.commissionerRegular(size: 16)
        button.setImage(R.image.check(), for: .normal)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private lazy var dollars1: UIButton = {
        let button = UIButton()
        button.setTitle("доллары", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = R.font.commissionerRegular(size: 16)
        button.setImage(R.image.uncheck(), for: .normal)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel2 : UILabel = {
        let label = UILabel()
        label.text = "Залог за весь период"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    private lazy var depositField: BlueTextField = {
        let field = BlueTextField()
        field.placeholder = "Размер залога"
        return field
    }()
    
    private lazy var somsButton2: UIButton = {
        let button = UIButton()
        button.setTitle("сомы", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = R.font.commissionerRegular(size: 16)
        button.setImage(R.image.check(), for: .normal)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private lazy var dollars2: UIButton = {
        let button = UIButton()
        button.setTitle("доллары", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = R.font.commissionerRegular(size: 16)
        button.setImage(R.image.uncheck(), for: .normal)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: YellowButton = {
        let button = YellowButton()
        button.setTitle("Далее", for: .normal)
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func check(_ sender: UIButton) {
        if sender.currentImage == R.image.check() {
            sender.setImage(R.image.uncheck(), for: .normal)
            sender.tag = 0
            
        } else {
            sender.setImage(R.image.check(), for: .normal)
            sender.tag = 1
        }
        
        if sender == somsButton1 && sender.currentImage == R.image.check() {
            dollars1.setImage(R.image.uncheck(), for: .normal)
            dollars1.tag = 0
        } else if sender == dollars1 && sender.currentImage == R.image.check() {
            somsButton1.setImage(R.image.uncheck(), for: .normal)
            somsButton1.tag = 0
        }
        
        if sender == somsButton2 && sender.currentImage == R.image.check() {
            dollars2.setImage(R.image.uncheck(), for: .normal)
            dollars2.tag = 0
        } else if sender == dollars2 && sender.currentImage == R.image.check() {
            somsButton2.setImage(R.image.uncheck(), for: .normal)
            somsButton2.tag = 0
        }
    }

}

extension RentSubmitView {
    
    private func setupSubviews() {
        addSubviews(
            titleLabel1,
            rentField,
            somsButton1,
            dollars1,
            titleLabel2,
            depositField,
            somsButton2,
            dollars2,
            nextButton
        )
    }
    
    private func setupConstraints() {
        titleLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(108)
            make.left.right.equalToSuperview().inset(17)
        }
        
        rentField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel1.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        
        somsButton1.snp.makeConstraints { make in
            make.top.equalTo(rentField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        dollars1.snp.makeConstraints { make in
            make.top.equalTo(rentField.snp.bottom).offset(20)
            make.left.equalTo(somsButton1.snp.right).offset(42)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(somsButton1.snp.bottom).offset(43)
            make.left.right.equalToSuperview().inset(17)
        }
        
        depositField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel2.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        
        somsButton2.snp.makeConstraints { make in
            make.top.equalTo(depositField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        dollars2.snp.makeConstraints { make in
            make.top.equalTo(depositField.snp.bottom).offset(20)
            make.left.equalTo(somsButton1.snp.right).offset(42)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(tabbarHeight + tabbarHeight + 30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
}
