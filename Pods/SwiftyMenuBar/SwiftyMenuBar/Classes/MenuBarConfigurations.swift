//
//  MenuBarConfigurations.swift
//  SlidingMenuBar
//
//  Created by Jonathan Scala on 2019-08-26.
//  Copyright © 2019 Jonathan Scala. All rights reserved.
//

import UIKit


public class MenuBarConfigurations {
    public var startIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    public var selectedColor: UIColor = .black
    public var sliderColor: UIColor = .black
    public var barColor: UIColor = .white
    public var textColor: UIColor = .gray
    public var itemsPerPage: CGFloat = 3
    public var scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally
    public var font: UIFont = UIFont.systemFont(ofSize: 13)
    public var staticSize: Bool = true

    public init() {}
}
