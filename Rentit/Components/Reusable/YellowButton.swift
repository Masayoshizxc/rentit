//
//  BlueButton.swift
//  Rentit
//
//  Created by Eldiiar on 8/11/22.
//

import UIKit

class YellowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.yellow()
        titleLabel?.font = R.font.commissionerSemiBold(size: 20)
        setTitleColor(R.color.coal(), for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 28
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
