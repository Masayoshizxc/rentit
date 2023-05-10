//
//  ViewController.swift
//  Rentit
//
//  Created by Adilet on 11/10/22.
//

import UIKit

enum TabbarItems: CaseIterable {
    case first
    case second
    case third
    case fourth
    case fifth
    
    var tabbarItem: UITabBarItem {
        switch self {
        case .first:
            return .init(
                title: "Главная",
                image: .init(named: "home"),
                tag: 1
            )
        case .second:
            return .init(
                title: "Избранное",
                image: .init(named: "favorites"),
                tag: 1
            )
        case .third:
            return .init(
                title: "Подать",
                image: .init(named: "submit"),
                tag: 1
            )
        case .fourth:
            return .init(
                title: "Сообщения",
                image: .init(named: "chat"),
                tag: 1
            )
        case .fifth:
            return .init(
                title: "Профиль",
                image: .init(named: "profile"),
                tag: 1
            )
        }
    }
}



class TabBarController: UITabBarController {
    weak var coordinator: TabBarCoordinator?
    
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
    let postCoordinator = PostProductCoordinator(navigationController: UINavigationController())
    let chatCoordinator = ChatCoordinator(navigationController: UINavigationController())
    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
        UITabBar.appearance().tintColor = UIColor(red: 62/255, green: 174/255, blue: 255/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 137/255, green: 149/255, blue: 172/255, alpha: 0.8)
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureTabs() {
        homeCoordinator.start()
//        homeCoordinator.parentCoordinator = coordinator
        favoritesCoordinator.start()
        //favoritesCoordinator.parentCoordinator = coordinator
        postCoordinator.start()
        chatCoordinator.start()
        profileCoordinator.start()
        viewControllers = [
            homeCoordinator.navigationController,
            favoritesCoordinator.navigationController,
            postCoordinator.navigationController,
            chatCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
        
    }
    
}
