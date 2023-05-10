//
//  AdvertisementsViewController.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import UIKit

class AdvertisementsViewController: UIViewController {
    
    weak var coordinator: FavoritesCoordinator?
    private var ui = AdvertisementsView()
    private let viewModel:AdvertisementsViewModelProtocol
    
    init(viewModel: AdvertisementsViewModelProtocol = AdvertisementsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ui
        setupSubviews()
        setupConstraints()
    }
}

extension AdvertisementsViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
