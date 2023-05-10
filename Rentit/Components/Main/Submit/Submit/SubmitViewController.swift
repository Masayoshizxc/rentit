//
//  SubmitViewController.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit

class SubmitViewController: BaseViewController {
    
    var arr = [Category]()
    var array = [String]()
    
    var model = [String:Any]()
    
    var count = 0
    
    weak var coordinator: PostProductCoordinator?
    
    lazy var ui = SubmitView()
    let viewModel:SubmitViewModelProtocol
    
    init(viewModel: SubmitViewModelProtocol = SubmitViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Новое объявление"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.cardbac(), style: .plain, target: self, action: #selector(didTapBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сбросить", style: .plain, target: self, action: #selector(didTapReset))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        if #available(iOS 16.0, *) {
            if count == 0 {
                navigationItem.leftBarButtonItem?.isHidden = true
            }
        } else {
            // Fallback on earlier versions
        }
        
        getCategory()
        
        ui.tableView.delegate = self
        ui.tableView.dataSource = self
    }
    
    @objc func didTapBack() {
        guard count > 0 else {
            return
        }
        count -= 1
        switch count {
        case 0:
            ui.titleLabel.text = "Выберите категорию"
            getCategory()
            if #available(iOS 16.0, *) {
                if count == 0 {
                    navigationItem.leftBarButtonItem?.isHidden = true
                }
            } else {
                // Fallback on earlier versions
            }
        case 1:
            ui.titleLabel.text = "Выберите подкатегорию"
            getSubCategory(id: model["categoryId"] as! Int)
        case 2:
            ui.titleLabel.text = "Выберите срок размещения"
            array = ["Посуточно", "Долгосрочно"]
        case 3:
            ui.titleLabel.text = "Кто сдает"
            array = ["Собственник", "Посредник"]
        default:
            print("Error")
        }
        ui.tableView.reloadData()
    }
    
    func getCategory() {
        viewModel.getCategory { result in
            switch result {
            case .success:
                print("Success")
                DispatchQueue.main.async {
                    self.arr = self.viewModel.categories
                    self.ui.tableView.reloadData()
                }
            case .failure:
                print("Error")
            }
        }
    }
    
    func getSubCategory(id: Int) {
        viewModel.getSubCategory(id: id) { result in
            switch result {
            case .success:
                print("Successfully got sub categories")
                DispatchQueue.main.async {
                    self.arr = self.viewModel.categories
                    self.ui.tableView.reloadData()
                }
            case .failure:
                print("Error")
            }
        }
    }
    
    @objc func didTapReset() {
        
    }
    
}

extension SubmitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch count {
        case 0...1:
            return arr.count
        case 2...4:
            return array.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch count {
        case 0...1:
            cell.textLabel?.text = arr[indexPath.row].name
        case 2...4:
            cell.textLabel?.text = array[indexPath.row]
        default:
            print("Error")
        }
        cell.textLabel?.font = R.font.commissionerRegular(size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        count += 1
        if #available(iOS 16.0, *) {
            if count != 0 {
                navigationItem.leftBarButtonItem?.isHidden = false
            }
        } else {
            // Fallback on earlier versions
        }
        switch count {
        case 1:
            //model["categoryId"] = arr[indexPath.row].id
            ui.titleLabel.text = "Выберите подкатегорию"
            getSubCategory(id: arr[indexPath.row].id ?? 0)
        case 2:
            model["categoryId"] = arr[indexPath.row].id
            ui.titleLabel.text = "Выберите срок размещения"
            array = ["Посуточно", "Долгосрочно"]
        case 3:
            model["condition"] = array[indexPath.row]
            ui.titleLabel.text = "Кто сдает"
            array = ["Собственник", "Посредник"]
            
        case 4:
            model["typeOfRental"] = array[indexPath.row]
            coordinator?.goToPhoto(model: model)
        default:
            print("Error")
        }
        tableView.reloadData()
    }
    
    
}

extension SubmitViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
