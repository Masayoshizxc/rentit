//
//  MenuBarCell.swift
//  SlidingMenuBar
//
//  Created by Jonathan Scala on 2019-08-26.
//  Copyright © 2019 Jonathan Scala. All rights reserved.
//

import UIKit


class MenuBarCell: UICollectionViewCell {
    public var staticSize: Bool = true
    public var selectedColor: UIColor? = .black
    public var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var font: UIFont? = UIFont.systemFont(ofSize: 13) {
        didSet {
            label.font = font
        }
    }
    
    public var textColor: UIColor? = .white {
        didSet {
            label.textColor = isSelected ? selectedColor : textColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? selectedColor : textColor
            if !staticSize {
                UIView.animate(withDuration: 0.2) {
                    self.label.transform = self.isSelected ?  CGAffineTransform(scaleX: 1.4, y: 1.4) : .identity
                }
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.label.textColor = self.isSelected ? self.selectedColor : self.textColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //layer.cornerRadius = 15
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
