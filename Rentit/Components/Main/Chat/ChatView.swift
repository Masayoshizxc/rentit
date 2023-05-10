//
//  ChatView.swift
//  Rentit
//
//  Created Eldiiar on 3/11/22.
//

import UIKit
// swiftlint:disable all

protocol ChatViewProtocol {
    func didTapSupport()
}

class ChatView: UIView {
    
    var delegate: ChatViewProtocol? = nil
    
    private lazy var supportView: SupportView = {
        let view = SupportView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSupport))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func didTapSupport() {
        if delegate != nil {
            delegate?.didTapSupport()
        }
    }
}

extension ChatView {
    
    private func setupSubviews() {
        addSubviews(
            supportView,
            tableView
        )
    }
    
    private func setupConstraints() {
        supportView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(108)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(63)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(supportView.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
