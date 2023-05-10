//
//  SellersViewController.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import UIKit

class SellersViewController: UIViewController {
    
    weak var coordinator: FavoritesCoordinator?
    private var ui = SellersView()
    private let viewModel:SellersViewModelProtocol
    
    init(viewModel: SellersViewModelProtocol = SellersViewModel()) {
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

extension SellersViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
