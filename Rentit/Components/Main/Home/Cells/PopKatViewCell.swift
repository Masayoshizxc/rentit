//
//  PopKatViewCell.swift
//  Rentit
//
//  Created by Adilet on 14/10/22.
//

import UIKit

class PopKatViewCell: UICollectionViewCell {
    static let reuseID = "PopKatView"
    
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = contentView.bounds
    }
}
