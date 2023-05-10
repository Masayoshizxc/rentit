//
//  GrayishButton.swift
//  Rentit
//
//  Created by Eldiiar on 8/11/22.
//

import UIKit

class GrayishButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.whiteGray()
        titleLabel?.font = R.font.commissionerSemiBold(size: 20)
        setTitleColor(UIColor.gray, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 28
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
