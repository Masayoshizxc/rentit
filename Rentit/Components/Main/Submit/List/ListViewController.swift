//
//  ListViewController.swift
//  Rentit
//
//  Created Eldiiar on 11/11/22.
//

import UIKit

protocol ListProtocol {
    func sendData(_ data: String)
}

class ListViewController: UIViewController {
    
    var arr = [String]()
    var delegate: ListProtocol? = nil
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var ui = ListView()
    private let viewModel:ListViewModelProtocol
    
    init(viewModel: ListViewModelProtocol = ListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSubviews()
        setupConstraints()
    }
}

extension ListViewController {
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.delegate != nil {
            self.delegate?.sendData(arr[indexPath.row])
            dismiss(animated: true)
        }
    }
    
    
}
