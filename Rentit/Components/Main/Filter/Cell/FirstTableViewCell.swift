//
//  TableViewCell.swift
//  Rentit
//
//  Created by Adilet on 12/11/22.
//

import UIKit
import SnapKit

class FirstTableViewCell: UITableViewCell {
    static let reuseID = "cell1"
    
    lazy var place: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Medium", size: 12)
        lbl.textColor = .grayTabBar
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(place)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(titleLabel: String) {
        place.text = titleLabel
    }
    
    func setUpConstraints() {
        place.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
        }
    }
}

class SecondTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
