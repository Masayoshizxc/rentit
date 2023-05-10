//
//  TableView.swift
//  Rentit
//
//  Created by Eldiiar on 16/11/22.
//

import UIKit

class TableView: UITableView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
    
}
