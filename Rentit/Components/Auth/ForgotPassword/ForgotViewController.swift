//
//  ForgotViewController.swift
//  Rentit
//
//  Created Eldiiar on 8/11/22.
//

import UIKit

class ForgotViewController: BaseViewController {
    
    weak var coordinator: MainCoordinator?
    private var ui = ForgotView()
    private let viewModel:ForgotViewModelProtocol
    
    init(viewModel: ForgotViewModelProtocol = ForgotViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Восстановление пароля"
        view = ui
        ui.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didTapContinue() {
        guard let email = ui.emailField.text else { return }
        viewModel.forgotPassword(email: email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let sheet = UIAlertController(title: "Успешно", message: "На вашу почту отправлен код.", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    let vc = ResetViewController()
                    vc.email = email
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

extension ForgotViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
