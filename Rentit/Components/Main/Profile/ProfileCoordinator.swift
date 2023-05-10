//
//  ProfileCoordinator.swift
//  Rentit
//
//  Created by Eldiiar on 23/11/22.
//

import UIKit


class ProfileCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ProfileViewController()
        vc.coordinator = self
        vc.tabBarItem = TabbarItems.fifth.tabbarItem
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToSettings() {
        let vc = SettingsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func logOut() {
        self.finish()
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
        
        if let authViewController = fromViewController as? AuthViewController {
            childDidFinish(authViewController.coordinator)
        }
    }
    
}
