//
//  RentSubmitViewController.swift
//  Rentit
//
//  Created Eldiiar on 12/11/22.
//

import UIKit

class RentSubmitViewController: BaseViewController {
    
    var attributes = [Int:Any]()
    var model = [String: Any]()
    var imagesData = [Data]()
    
    weak var coordinator: PostProductCoordinator?
    private lazy var ui = RentSubmitView()
    let viewModel: RentSubmitViewModelProtocol
    
    init(viewModel: RentSubmitViewModelProtocol = RentSubmitViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новое объявление"
        view = ui
        print(model)
        ui.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didTapNextButton() {
//        print(somsButton1.tag, dollars1.tag)
//        print(somsButton2.tag, dollars2.tag)
        model["price"] = ui.rentField.text
        print(model)
        viewModel.postProduct(params: model, attributes: attributes, imagesData: imagesData) { result in
            switch result {
            case .success:
                self.coordinator?.start()
            case .failure:
                print("Error")
            }
        }
    }
}

extension RentSubmitViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
