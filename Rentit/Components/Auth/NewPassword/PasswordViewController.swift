//
//  PasswordViewController.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit

class PasswordViewController: UIViewController {
    
    var token = ""
    private var ui = PasswordView()
    private let viewModel:PasswordViewModelProtocol
    
    init(viewModel: PasswordViewModelProtocol = PasswordViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ui
        ui.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didTapContinue() {
        guard let password = ui.passField.text else { return }
        viewModel.changePassword(code: token, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let sheet = UIAlertController(title: "Успешно", message: "Ваш пароль успешно изменен", preferredStyle: .alert)
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

extension PasswordViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
