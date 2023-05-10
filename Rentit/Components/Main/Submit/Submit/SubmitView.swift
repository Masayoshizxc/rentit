//
//  SubmitView.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit

class SubmitView: UIView {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберите категорию"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .white
        return tableView
    }()
        
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension SubmitView {
    
    private func setupSubviews() {
        addSubviews(
            titleLabel,
            tableView
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(108)
            make.left.equalToSuperview().inset(17)
            make.right.equalToSuperview().inset(17)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
