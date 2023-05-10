//
//  PostProductCoordinator.swift
//  Rentit
//
//  Created by Eldiiar on 22/11/22.
//

import UIKit

class PostProductCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SubmitViewController()
        vc.coordinator = self
        vc.tabBarItem = TabbarItems.third.tabbarItem
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: 15, right: 0)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPhoto(model: [String:Any]) {
        let vc = PhotoViewController()
        vc.coordinator = self
        vc.model = model
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToInfo(model: [String:Any], imagesData: [Data]) {
        let vc = InfoViewController()
        vc.coordinator = self
        vc.model = model
        vc.imagesData = imagesData
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToSubmit(model: [String:Any], imagesData: [Data], attributes: [Int:Any]) {
        let vc = RentSubmitViewController()
        vc.coordinator = self
        vc.imagesData = imagesData
        vc.model = model
        vc.attributes = attributes
        navigationController.pushViewController(vc, animated: true)
    }
    
}
