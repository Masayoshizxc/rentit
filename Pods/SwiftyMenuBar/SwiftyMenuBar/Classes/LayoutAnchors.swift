//
//  LayoutAnchors.swift
//  SlidingMenuBar
//
//  Created by Jonathan Scala on 2019-08-27.
//  Copyright © 2019 Jonathan Scala. All rights reserved.
//

import UIKit


extension UIView {
    public func fillSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    public func centerInSuperview() {
        centerXInSuperview()
        centerYInSuperview()
    }
    
    public func centerXInSuperview(constant: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
    }
    
    public func centerYInSuperview(constant: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }
    
    public func constrain(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        if widthConstant > 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        if heightConstant > 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
    public func constrainWidth(parent: NSLayoutDimension? = nil, widthConstant: CGFloat = 0, widthMultiplier: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        if let parent = parent {
            widthAnchor.constraint(equalTo: parent, multiplier: widthMultiplier, constant: widthConstant).isActive = true
        } else {
            if widthConstant > 0 {
                widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
            }
        }
    }
    
    public func constrainHeight(parent: NSLayoutDimension? = nil, heightConstant: CGFloat = 0, heightMultiplier: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        if let parent = parent {
            heightAnchor.constraint(equalTo: parent, multiplier: heightMultiplier, constant: heightConstant).isActive = true
        } else {
            if heightConstant > 0 {
                heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
            }
        }
    }
}
