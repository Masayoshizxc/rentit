//
//  InfoView.swift
//  Rentit
//
//  Created Eldiiar on 11/11/22.
//

import UIKit

protocol InfoViewProtocol {
    func didTapNextButton()
}

class InfoView: UIView {
    
    var delegate: InfoViewProtocol? = nil
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Информация о квартире"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "infoCell")
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var nextButton: YellowButton = {
        let button = YellowButton()
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
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
    
    @objc func didTapNextButton() {
        if delegate != nil {
            delegate?.didTapNextButton()
        }
    }
    
}

extension InfoView {
    
    private func setupSubviews() {
        addSubviews(
            infoTableView,
            titleLabel,
            nextButton
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.left.right.equalToSuperview().inset(16)
        }
        
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.right.bottom.equalToSuperview()
            
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
}

extension InfoView: ListProtocol {
    func sendData(_ data: String) {
        print(data)
    }
}
