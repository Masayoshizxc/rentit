//
//  CompareCollectionViewCell.swift
//  Rentit
//
//  Created by Eldiiar on 24/11/22.
//

import UIKit

struct Compare {
    let section: String
    let row: String
}

class CompareCollectionViewCell: UICollectionViewCell {
    
    var arr = [Compare]()
    var type = 0
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var tableView: TableView = {
        let tableView = TableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "compareCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpSubviews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setData(model: Product) {
        headerView.setData(model: model)
        arr.append(Compare(section: "Описание", row: model.description ?? ""))
        arr.append(Compare(section: "Местоположение", row: model.address?.street ?? ""))
        arr.append(Compare(section: "Тип аренды", row: model.condition ?? ""))
        guard let attributes = model.attributesList else { return }
        for i in 0..<(attributes.count ) {
            arr.append(Compare(section: attributes[i].attributeName ?? "", row: attributes[i].value ?? ""))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CompareCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if type == 0 {
            return arr[section].section
        } else {
            return " "
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = R.font.commissionerSemiBold(size: 14)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "compareCell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.section].row
        cell.textLabel?.textColor = R.color.grayish()
        cell.textLabel?.font = R.font.commissionerRegular(size: 12)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .left
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .cyan
//        return view
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 130
//    }
    
    
}

extension CompareCollectionViewCell {
    
    func setUpSubviews() {
        addSubviews(
            headerView,
            tableView
        )
    }
    
    func setUpConstraints() {
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(160)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
