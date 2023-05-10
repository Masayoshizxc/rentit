//
//  CardTableViewCell.swift
//  Rentit
//
//  Created by Eldiiar on 16/11/22.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 0.7)
        label.font = R.font.commissionerMedium(size: 12)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.grayish()
        label.font = R.font.commissionerMedium(size: 12)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubviews(
            titleLabel,
            valueLabel
        )
        
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(title: String, value: String) {
        titleLabel.text = "\(title):"
        valueLabel.text = value
    }
    
    func setUpConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(5)
        }
    }
}
