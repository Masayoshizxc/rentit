//
//  CompareViewController.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import UIKit

class CompareViewController: BaseViewController {
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame.size = contentSize
        return view
    }()
    
    weak var coordinator: FavoritesCoordinator?
    private var ui = CompareView()
    private let viewModel:CompareViewModelProtocol
    
    init(viewModel: CompareViewModelProtocol = CompareViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сравнить объявления"
//        view = ui
        ui.frame.size = contentSize
        view.addSubview(scrollView)
        scrollView.addSubview(ui)
        ui.collectionView.delegate = self
        ui.collectionView.dataSource = self
        
        viewModel.getCompare(productIds: [1, 1, 1]) { result in
            switch result {
            case .success:
                print("Success")
                DispatchQueue.main.async {
                    self.ui.collectionView.reloadData()
                }
            case .failure:
                print("Error")
            }
        }
        setupSubviews()
        setupConstraints()
    }
}


extension CompareViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(CompareCollectionViewCell.self, indexPath: indexPath)
        if indexPath.row == 0 {
            cell.type = 0
        } else {
            cell.type = 1
        }
        cell.setData(model: viewModel.product[indexPath.row])
        return cell
    }
        
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2 - 16, height: contentSize.height - 146)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension CompareViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
