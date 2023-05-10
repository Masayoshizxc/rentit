//
//  CompareViewController.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import UIKit

class CompareListViewController: UIViewController {
    
    weak var coordinator: FavoritesCoordinator?
    private var ui = CompareListView()
    private let viewModel: CompareListViewModelProtocol
    
    init(viewModel: CompareListViewModelProtocol = CompareListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ui
        ui.tableView.delegate = self
        ui.tableView.dataSource = self
        setupSubviews()
        setupConstraints()
    }
}

extension CompareListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Flats"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.goToCompare()
    }
    
    
}

extension CompareListViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
