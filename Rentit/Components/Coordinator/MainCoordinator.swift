//
//  MainCoordinator.swift
//  Rentit
//
//  Created by Eldiiar on 22/11/22.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userDefaults = UserDefaultsService.shared
        navigationController.delegate = self
        print(userDefaults.didSignedIn())
        if !userDefaults.didSignedIn() {
            let vc = AuthViewController()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        } else {
            let child = TabBarCoordinator(navigationController: navigationController)
            childCoordinators.append(child)
            child.parentCoordinator = self
            child.start()
        }
    }
    
    func goTabBar() {
        let child = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func login() {
//        let child = LoginCoordinator(navigationController: navigationController)
//        childCoordinators.append(child)
//        child.parentCoordinator = self
//        child.start()
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func forgotPassword() {
        let vc = ForgotViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func register() {
        let vc = RegisterViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                print(childCoordinators)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let loginViewController = fromViewController as? LoginViewController {
            childDidFinish(loginViewController.coordinator)
        }
    }
    
}
