//
//  SearchField.swift
//  Rentit
//
//  Created by Adilet on 12/11/22.
//

import UIKit

class SearchField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont(name: "Commissioner-Medium", size: 16)
        placeholder = "Поиск"
        leftViewMode = UITextField.ViewMode.always
        leftView?.backgroundColor = .red
//        leftView?.contentMode = .center
        leftView?.frame.size.width = 100
        leftView = UIImageView(image: UIImage(named: "search"))
        leftView?.contentMode = .center
        layer.cornerRadius = 25
        leftView?.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
