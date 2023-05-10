//
//  FullViewController.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit
import Alamofire

class FullViewController: UIViewController {
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 480)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "Пройдя полную регистрацию, вы сможете использовать  все функции Rent It - общаться с другими пользователями, оставлять отзывы, размещать объявления и многое другое."
        label.numberOfLines = 0
        label.font = R.font.commissionerRegular(size: 13)
        label.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        return label
    }()
    
    lazy var phoneField: TextField = {
        let field = TextField()
        field.placeholder = "Адрес электронной почты"
        return field
    }()
    
    private lazy var attentionLabel : UILabel = {
        let label = UILabel()
        label.text = "Данные должны совпадать с паспортом"
        label.font = R.font.commissionerSemiBold(size: 14)
        return label
    }()
    
    lazy var surnameField: TextField = {
        let field = TextField()
        field.placeholder = "Фамилия"
        field.autocapitalizationType = .words
        return field
    }()
    
    lazy var nameField: TextField = {
        let field = TextField()
        field.placeholder = "Имя"
        field.autocapitalizationType = .words
        return field
    }()
    
    lazy var middleNameField: TextField = {
        let field = TextField()
        field.placeholder = "Отчество"
        field.autocapitalizationType = .words
        return field
    }()
    
    lazy var dobField: TextField = {
        let field = TextField()
        field.placeholder = "Дата рождения"
        return field
    }()
    
    lazy var passportNumField: TextField = {
        let field = TextField()
        field.placeholder = "Номер паспорта"
        return field
    }()
    
    lazy var innField: TextField = {
        let field = TextField()
        field.placeholder = "ИНН"
        field.keyboardType = .numberPad
        return field
    }()
    
    lazy var passGivenDateField: TextField = {
        let field = TextField()
        field.placeholder = "Дата выдачи паспорта"
        return field
    }()
    
    lazy var passGivenOrgField: TextField = {
        let field = TextField()
        field.placeholder = "Орган, выдавший паспорт"
        return field
    }()
    
    lazy var expiryDateField: TextField = {
        let field = TextField()
        field.placeholder = "Дата окончания срока действия"
        return field
    }()
    
    lazy var addressField: TextField = {
        let field = TextField()
        field.placeholder = "Адрес прописки"
        return field
    }()
    
    private lazy var checkLabel : UILabel = {
        let label = UILabel()
        label.text = "Проверьте правильность введенных данных"
        label.textColor = R.color.blue()
        label.font = R.font.commissionerSemiBold(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var frontPassImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.front()
        return imageView
    }()
    
    private lazy var backPassImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.back()
        return imageView
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.userImg()
        return imageView
    }()

    
    lazy var continueButton: GrayishButton = {
        let button = GrayishButton()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private var ui = FullView()
    private let viewModel:FullViewModelProtocol
    
    init(viewModel: FullViewModelProtocol = FullViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view = ui
        
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didTapRegisterButton() {
        let images = [UIImage(systemName: "person")!, UIImage(systemName: "person")!, UIImage(systemName: "person")!]
        var imagesData = [Data]()
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 1) else { return }
            imagesData.append(imageData)
        }
        
        let userDefaults = UserDefaultsService.shared
        let header = HTTPHeader(name: "Authorization", value: "Bearer \(userDefaults.getByKey(key: .access))")
        let params = [
            "userId": "5"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            for i in 0..<imagesData.count {
                multipartFormData.append(imagesData[i], withName: "file", fileName: "photo\(i).jpg", mimeType: "image/jpeg")
            }
            for (key, value) in params {
                print(key, value)
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: "http://128.199.30.62:8080/api/auth/full-registration-save-image/5", method: .post, headers: [header])
        .responseDecodable(of: FailureModel.self) { response in
            debugPrint(response)
        }
        
        
        guard let email = phoneField.text,
              let firstName = nameField.text, let lastName = surnameField.text
        else { return
        }
        let parameters: [String : Any] = [
            "first_name" : firstName,
            "last_name" : lastName,
            "email" : email,
            "passNum" : 0,
            "issuedDatePass" : passGivenDateField.text!,
            "issuedAuthorityPass" : passGivenOrgField.text!,
            "expDatePass" : expiryDateField.text!,
            "country" : "Kyrgyzstan",
            "city" : "Bishkek",
            "street" : addressField.text!,
            "inn" : innField.text!,
            "password" : "password"
        ]
        viewModel.signUp(params: parameters) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let sheet = UIAlertController(title: "Успешно", message: "На вашу почту отправлен код.", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    let vc = AuthViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.dismiss(animated: true)
                }))
                self.present(sheet, animated: true)
            case .failure:
                print("error")
            }
        }
    }
    
}

extension FullViewController {
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubviews(
            descLabel,
            phoneField,
            attentionLabel,
            surnameField,
            nameField,
            middleNameField,
            dobField,
            passportNumField,
            innField,
            passGivenDateField,
            passGivenOrgField,
            expiryDateField,
            addressField,
            checkLabel,
            frontPassImage,
            backPassImage,
            userImage,
            continueButton
        )
    }
    
    private func setupConstraints() {
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(40)
        }
        
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        attentionLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(40)
        }
        
        surnameField.snp.makeConstraints { make in
            make.top.equalTo(attentionLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(surnameField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        middleNameField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        dobField.snp.makeConstraints { make in
            make.top.equalTo(middleNameField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        passportNumField.snp.makeConstraints { make in
            make.top.equalTo(dobField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        innField.snp.makeConstraints { make in
            make.top.equalTo(passportNumField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        passGivenDateField.snp.makeConstraints { make in
            make.top.equalTo(innField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        passGivenOrgField.snp.makeConstraints { make in
            make.top.equalTo(passGivenDateField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        expiryDateField.snp.makeConstraints { make in
            make.top.equalTo(passGivenOrgField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        addressField.snp.makeConstraints { make in
            make.top.equalTo(expiryDateField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(addressField.snp.bottom).offset(22)
            make.left.right.equalToSuperview().inset(40)
        }
        
        frontPassImage.snp.makeConstraints { make in
            make.top.equalTo(checkLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(90)
        }
        
        backPassImage.snp.makeConstraints { make in
            make.top.equalTo(frontPassImage.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(90)
        }
        
        userImage.snp.makeConstraints { make in
            make.top.equalTo(backPassImage.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(90)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
    }
}
