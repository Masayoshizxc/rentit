//
//  SettingsView.swift
//  Rentit
//
//  Created Eldiiar on 5/11/22.
//

import UIKit

protocol SettingsViewProtocol {
    func didTapLogOut()
}

class SettingsView: UIView {
    
    var delegate: SettingsViewProtocol? = nil
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        return button
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
    
    @objc func didTapLogOut() {
        delegate?.didTapLogOut()
    }
}

extension SettingsView {
    
    private func setupSubviews() {
        addSubviews(
            logOutButton
        )
    }
    
    private func setupConstraints() {
        logOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
    }
}
