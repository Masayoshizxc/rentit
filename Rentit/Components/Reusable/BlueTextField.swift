//
//  BlueTextField.swift
//  Rentit
//
//  Created by Eldiiar on 12/11/22.
//

import UIKit

class BlueTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        autocorrectionType = .no
        backgroundColor = R.color.whiteGray()
        layer.cornerRadius = 5
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        font = R.font.commissionerRegular(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
