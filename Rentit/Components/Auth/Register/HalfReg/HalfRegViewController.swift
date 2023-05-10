//
//  HalfRegViewController.swift
//  Rentit
//
//  Created Eldiiar on 26/10/22.
//

import UIKit


class HalfRegViewController: BaseViewController {
    
    private var ui = HalfRegView()
    private let viewModel:HalfRegViewModelProtocol
    
    init(viewModel: HalfRegViewModelProtocol = HalfRegViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = ui
        ui.continueButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    @objc func didTapRegisterButton() {
        guard let email = ui.phoneField.text, let password = ui.passwordField.text,
              let firstName = ui.nameField.text, let lastName = ui.surnameField.text
        else { return
        }
        let parameters: [String : Any] = [
            "first_name" : firstName,
            "last_name" : lastName,
            "email" : email,
            "password" : password
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
