//
//  RegisterViewController.swift
//  Rentit
//
//  Created by Eldiiar on 14/10/22.
//

import UIKit
import SwiftyMenuBar

class RegisterViewController: BaseViewController {
    
    weak var coordinator: MainCoordinator?
    
    lazy var config: MenuBarConfigurations = {
        let config = MenuBarConfigurations()
        config.itemsPerPage = 2
        config.font = R.font.commissionerSemiBold(size: 18)!
        config.barColor = .white
        config.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        config.selectedColor = R.color.blue()!
        config.sliderColor = R.color.blue()!
        return config
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация аккаунта"
        
        let titles = ["Частичная", "Полная"]
        let vcs: [UIViewController] = [
            HalfRegViewController(),
            FullViewController()
        ]
        let menu: MenuBarController = MenuBarController(viewControllers: vcs, titles: titles)
        menu.configuration = config
        addChild(menu)
        view.addSubview(menu.view)
    }
    


}
