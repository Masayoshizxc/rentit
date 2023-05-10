//
//  MenuBar.swift
//  SlidingMenuBar
//
//  Created by Jonathan Scala on 2019-08-26.
//  Copyright © 2019 Jonathan Scala. All rights reserved.
//
import UIKit


public protocol MenuBarDelegate {
    func didSelectItem(indexPath: IndexPath)
}


public class MenuBar: UIView {
    fileprivate var leftAnchorConstraint : NSLayoutConstraint?
    fileprivate var widthAnchorConstraint: NSLayoutConstraint?
    fileprivate var selectedIndexPath: IndexPath?
    fileprivate var titles: [String] = []
    fileprivate var index: Int = 0
    fileprivate let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    fileprivate lazy var selectedView: UIView = {
        let selectedView = UIView()
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        return selectedView
    }()
    
    // Returns the number of titles in the menu
    public fileprivate(set) var numberOfSections: Int {
        get {
            return titles.count
        }
        set { }
    }
    
    public var barColor: UIColor = .gray {
        didSet {
            collectionView.backgroundColor = barColor
        }
    }
    
    public var sliderColor: UIColor? = .white {
        didSet {
            selectedView.backgroundColor = self.sliderColor
        }
    }
    
    public var configuration = MenuBarConfigurations() {
        didSet {
            applyConfiguration()
            collectionView.reloadData()
            collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .left)
        }
    }
    
    public var textColor: UIColor?
    public var selectedColor: UIColor?
    public var font: UIFont?
    public var delegate: MenuBarDelegate?
    
    
    public init(titles: [String]) {
        super.init(frame: .zero)
        self.titles = titles
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.addSubview(selectedView)
        addSubview(collectionView)
        
        // Constraints
        selectedView.heightAnchor.constraint(equalToConstant: 2.5).isActive = true
        selectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftAnchorConstraint = selectedView.leftAnchor.constraint(equalTo: collectionView.leftAnchor)
        widthAnchorConstraint = selectedView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / configuration.itemsPerPage)
        
        // Activate Constraints
        leftAnchorConstraint?.isActive = true
        widthAnchorConstraint?.isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        applyConfiguration()
    }
    
    public convenience init(frame: CGRect, titles: [String], configuration: MenuBarConfigurations) {
        self.init(titles: titles)
        self.frame = frame
        self.configuration = configuration
        applyConfiguration()
    }
    
    public convenience init(titles: [String], configuration: MenuBarConfigurations) {
        self.init(titles: titles)
        self.configuration = configuration
        applyConfiguration()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        collectionView.fillSuperview()
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }

    fileprivate func applyConfiguration() {
        // SET COLORS
        textColor = configuration.textColor
        selectedColor = configuration.selectedColor
        barColor = configuration.barColor
        font = configuration.font
        sliderColor = configuration.sliderColor
        sliderColor = configuration.sliderColor
        
        // SET START POSITION
        if titles.count > 0 {
            collectionView.selectItem(at: configuration.startIndexPath, animated: true, scrollPosition: configuration.scrollPosition)
        }
        
        // SET CELL SIZING
        widthAnchorConstraint?.isActive = false
        widthAnchorConstraint = selectedView.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1 / configuration.itemsPerPage)
        widthAnchorConstraint?.isActive = true
    }
    
    public func update(contentOffset: CGFloat, indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: configuration.scrollPosition)
        leftAnchorConstraint?.constant = contentOffset / configuration.itemsPerPage
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuBarCell
        cell.label.text = titles[indexPath.row]
        cell.selectedColor = selectedColor
        cell.textColor = textColor
        cell.font = font
        cell.staticSize = configuration.staticSize
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / configuration.itemsPerPage, height: frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        moveSelectedBar(indexPathRow: indexPath.row)
        delegate?.didSelectItem(indexPath: indexPath)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: configuration.scrollPosition)
    }
    
    func scrollToNextCell(constant: CGFloat){
        let cellSize = CGSize(width: frame.width, height: frame.height)
        let contentOffset = collectionView.contentOffset
        collectionView.scrollRectToVisible(CGRect(x: floor(contentOffset.x + constant), y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }
    
    fileprivate func moveSelectedBar(indexPathRow: Int) {
        let cellWidth: CGFloat = frame.width / configuration.itemsPerPage
        self.leftAnchorConstraint?.constant = CGFloat(indexPathRow) * cellWidth
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
