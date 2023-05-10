//
//  ProductView.swift
//  Rentit
//
//  Created by Eldiiar on 27/11/22.
//

import UIKit

class ProductView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        
    }
}
