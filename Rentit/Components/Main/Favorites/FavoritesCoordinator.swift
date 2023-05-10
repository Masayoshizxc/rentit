//
//  FavoritesCoordinator.swift
//  Rentit
//
//  Created by Eldiiar on 23/11/22.
//

import UIKit

class FavoritesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: TabBarCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = FavoritesViewController()
        vc.coordinator = self
        vc.tabBarItem = TabbarItems.second.tabbarItem
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCompare() {
        let vc = CompareViewController()
        vc.coordinator = self
        vc.hidesBottomBarWhenPushed = true
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
//        if let compareViewController = fromViewController as? CompareViewController {
//            childDidFinish(compareViewController.coordinator)
//        }
    }
    
}
