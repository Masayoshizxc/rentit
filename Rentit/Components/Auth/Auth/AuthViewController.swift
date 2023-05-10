//
//  AuthViewController.swift
//  Rentit
//
//  Created by Eldiiar on 14/10/22.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.illustration()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rent It"
        label.textColor = R.color.blue()
        label.font = R.font.commissionerBold(size: 48)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginButton: YellowButton = {
        let button = YellowButton()
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.titleLabel?.font = R.font.commissionerSemiBold(size: 20)
        button.setTitleColor(R.color.blue(), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 1
        button.layer.borderColor = R.color.blue()?.cgColor
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить без авторизации", for: .normal)
        button.titleLabel?.font = R.font.commissionerSemiBold(size: 16)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        return button
    }()
    
    private lazy var agreementView: AgreementView = {
        let view = AgreementView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        view.addSubviews(
            imageView,
            titleLabel,
            loginButton,
            registerButton,
            continueButton,
            agreementView
        )
        
        setUpConstraints()
    }
    
    @objc func didTapLoginButton() {
        coordinator?.login()
    }
    
    @objc func didTapRegisterButton() {
        coordinator?.register()
    }
    
    @objc func didTapContinue() {
        coordinator?.goTabBar()
    }
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(widthComputed(247))
            make.bottom.equalTo(titleLabel.snp.top).inset(-47)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-15)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).inset(-40)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
        
        agreementView.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).inset(-36)
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
        }
        
    }

}

class AgreementView: UIView {
    
    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Продолжая, я соглашаюсь с"
        label.textColor = R.color.grayish()
        label.font = R.font.commissionerMedium(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var agreementLabel1: UILabel = {
        let label = UILabel()
        label.text = "условиями оферты"
        label.textColor = R.color.blue()
        label.font = R.font.commissionerMedium(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(
            agreementLabel,
            agreementLabel1
        )
        
        agreementLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        agreementLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(agreementLabel.snp.right).offset(3)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
