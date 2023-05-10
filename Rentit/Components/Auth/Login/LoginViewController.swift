//
//  AuthViewController.swift
//  Rentit
//
//  Created Eldiiar on 15/10/22.
//
// swiftlint:disable all
import UIKit
import Firebase

class LoginViewController: BaseViewController {
    
    weak var coordinator: MainCoordinator?
    private var ui = LoginView()
    private let viewModel:LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ui
        ui.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        ui.forgotPassword.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didTapLoginButton() {
        guard let email = ui.emailField.text, let password = ui.passwordField.text else { return
        }
//        let token = "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImNsYWltcyI6eyJhdXRob3JpdGllcyI6IlJPTEVfVVNFUiJ9LCJleHAiOjE2NzAwNjYxNTQsImlhdCI6MTY3MDA2MjU1NCwiaXNzIjoiZmlyZWJhc2UtYWRtaW5zZGstZXpjNHpAcmVudGl0LTM2NjQxNi5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInN1YiI6ImZpcmViYXNlLWFkbWluc2RrLWV6YzR6QHJlbnRpdC0zNjY0MTYuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJ1aWQiOiJvc21hbm96eWlsbWF6NDU2QGdtYWlsLmNvbSJ9.QAcjTIzuWwtLyiHuEciMAhVwPnfyNaIG_2LOr-fU0QO7ZkKhZODFa3ctABuinZESjOeTBmvUy7gAB5QHQ7qlwpZdzjTrc0pwudPq8WNSeNGOCy_It8BZcvQNXSdxL2Mf9bCmiklwFwHfYXBnmrIRUqqnJgdPvZan2ipnuPjbLT1jAnOvbFG4edMacY4pN9e6m8qtnx-xXjgA-or62MxTVbPH5End15kKw7uqr_5UabXPUzDb3HhXJbb5BfAkYXLgtkvFAaXNy6o859BOUnbfJtETKSeheXkjIY-gPyNY8x8c4WCNkmAuKdfB7OPAQxvWUegoMM7lY7JQdt1rhHjtog"
//        Auth.auth().signIn(withCustomToken: token ) { [weak self] authResult, error in
//          guard let strongSelf = self else { return }
//            print("This is thorugh Firebase", authResult?.user.uid, authResult?.user.providerID)
//        }
        
        viewModel.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let userDefaults = UserDefaultsService.shared
                userDefaults.isSignedIn(signedIn: true)
                self.coordinator?.goTabBar()
            case .failure:
                print("error")
            }
        }
    }
    
    @objc func didTapForgotPassword() {
        coordinator?.forgotPassword()
    }
}

extension LoginViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
