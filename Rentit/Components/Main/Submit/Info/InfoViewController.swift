//
//  InfoViewController.swift
//  Rentit
//
//  Created Eldiiar on 11/11/22.
//

import UIKit

class InfoViewController: BaseViewController, InfoViewProtocol {
    
    var attributes = [Int:Any]()
    var model = [String:Any]()
    var imagesData = [Data]()
    weak var coordinator: PostProductCoordinator?
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 40)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    
    
    private lazy var ui = InfoView()
    private let viewModel:InfoViewModelProtocol
    
    init(viewModel: InfoViewModelProtocol = InfoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новое объявление"
        getAttributes()
        setupSubviews()
        setupConstraints()
        
        ui.frame.size = contentSize
        ui.delegate = self
        ui.infoTableView.delegate = self
        ui.infoTableView.dataSource = self
    }
    
    func getAttributes() {
        viewModel.getAttributes(id: model["categoryId"] as! Int) { result in
            switch result {
            case .success:
                print(self.viewModel.attributes)
                self.ui.infoTableView.reloadData()
                self.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + self.ui.infoTableView.contentSize.height)
                self.scrollView.contentSize = self.contentSize
                self.containerView.frame.size = self.contentSize
            case .failure:
                print("Error")
            }
        }
    }
    
    func didTapNextButton() {
        coordinator?.goToSubmit(model: model, imagesData: imagesData, attributes: attributes)
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.attributes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        if indexPath.row == 0 {
            cell.setView(type: "address", title: "Адрес", value: ["1 floor", "2 floor", "3 floor"])
            cell.address = {
                //Selat' callback
                let vc = AddressViewController()
                vc.delegate = self
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            cell.setUpData(title: viewModel.attributes[indexPath.row - 1].name ?? "", id: viewModel.attributes[indexPath.row - 1].id ?? 0)
        }
        
        
//        cell.callback = {
//            let vc = ListViewController()
//            vc.arr = cell.dataSource
//            vc.delegate = self
//            if let presentationController = vc.presentationController as? UISheetPresentationController {
//                presentationController.detents = [.medium(), .large()]
//                presentationController.prefersGrabberVisible = true
//            }
//            self.viewController.present(vc, animated: true)
//        }
        
        cell.callback = { result in
            self.attributes[self.viewModel.attributes[indexPath.row - 1].id ?? 0] = result
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = ListViewController()
//        if let presentationController = vc.presentationController as? UISheetPresentationController {
//            presentationController.detents = [.medium(), .large()]
//            presentationController.prefersGrabberVisible = true
//        }
//        viewController.present(vc, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
}

extension InfoViewController: AddressProtocol {
    func sendData(_ address: ProductAddress) {
        model["country"] = address.country
        model["city"] = address.city
        model["street"] = address.street
    }
}

extension InfoViewController {
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(ui)
        
    }
    
    private func setupConstraints() {
        
    }
}
