//
//  FavoritesViewController.swift
//  Rentit
//
//  Created Eldiiar on 16/11/22.
//

import UIKit
import SwiftyMenuBar

class FavoritesViewController: UIViewController {
    
    private lazy var config: MenuBarConfigurations = {
        let conf = MenuBarConfigurations()
        conf.itemsPerPage = 2.5
        conf.font = R.font.commissionerSemiBold(size: heightComputed(14))!
        conf.barColor = .white
        conf.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        conf.selectedColor = R.color.blue()!
        conf.sliderColor = R.color.blue()!
        return conf
    }()
    
    
    weak var coordinator: FavoritesCoordinator?
    private var ui = FavoritesView()
    private let viewModel:FavoritesViewModelProtocol
    
    init(viewModel: FavoritesViewModelProtocol = FavoritesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
        view.backgroundColor = .white
//        view = ui
        let titles = [
            "Объявления",
            "Сравнения",
            "Продавцы"
        ]
        let vc1 = AdvertisementsViewController()
        let vc2 = CompareListViewController()
        let vc3 = SellersViewController()
        let vcs = [
            vc1,
            vc2,
            vc3
        ]
        vc1.coordinator = coordinator
        vc2.coordinator = coordinator
        let menu: MenuBarController = MenuBarController(viewControllers: vcs, titles: titles)
        menu.configuration = config
        addChild(menu)
        view.addSubview(menu.view)
        setupSubviews()
        setupConstraints()
    }
}

extension FavoritesViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
