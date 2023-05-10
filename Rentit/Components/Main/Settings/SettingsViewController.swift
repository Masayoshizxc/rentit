//
//  SettingsViewController.swift
//  Rentit
//
//  Created Eldiiar on 5/11/22.
//

import UIKit

class SettingsViewController: BaseViewController, SettingsViewProtocol {
    
    var mainCoordinator: MainCoordinator?
    weak var coordinator: ProfileCoordinator?
    private var ui = SettingsView()
    private let viewModel:SettingsViewModelProtocol
    
    init(viewModel: SettingsViewModelProtocol = SettingsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view = ui
        ui.delegate = self
        setupSubviews()
        setupConstraints()
    }
    
    func didTapLogOut() {
        DispatchQueue.main.async {
            print("yo")
            let userDefaults = UserDefaultsService.shared
            userDefaults.isSignedIn(signedIn: false)
            print(userDefaults.didSignedIn())
//            let vc = AuthViewController()
//            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
            let nav = UINavigationController()
            self.mainCoordinator = MainCoordinator(navigationController: nav)
            self.mainCoordinator?.start()
            //self.coordinator?.logOut()
        }
    }
}

extension SettingsViewController {
    
    private func setupSubviews() {
    }
    
    private func setupConstraints() {
        
    }
}
