//
//  TextField.swift
//  Rentit
//
//  Created by Eldiiar on 8/11/22.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        autocapitalizationType = .none
        autocorrectionType = .no
        let separatorView = UIView.init(frame: CGRect(x: 0, y: frame.size.height + 30, width: frame.size.width + 350, height: 1))
        separatorView.backgroundColor = .lightGray
        addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
