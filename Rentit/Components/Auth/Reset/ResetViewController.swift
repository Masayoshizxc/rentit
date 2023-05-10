//
//  ResetViewController.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit

class ResetViewController: UIViewController {
    
    var email = ""
    private var ui = ResetView()
    private let viewModel:ResetViewModelProtocol
    
    init(viewModel: ResetViewModelProtocol = ResetViewModel()) {
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
        guard let code = ui.codeField.text else { return }
        viewModel.resetPassword(code: code, email: email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let sheet = UIAlertController(title: "Успешно", message: "На вашу почту отправлен код.", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    let vc = PasswordViewController()
                    vc.token = code
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

extension ResetViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
