//
//  ViewController.swift
//  SlidingMenuBar
//
//  Created by Jonathan Scala on 2019-08-26.
//  Copyright © 2019 Jonathan Scala. All rights reserved.
//

import UIKit


// Delegate Class
@objc public protocol MenuBarControllerDelegate {
    @objc optional func menuBarController(_ menuBarController: MenuBarController, willScrollFrom startController: UIViewController, destinationController: UIViewController)
    @objc optional func menuBarController(_ menuBarController: MenuBarController, didScrollFrom startController: UIViewController, destinationController: UIViewController)
}


public class MenuBarController: UIViewController {
    public var delegate: MenuBarControllerDelegate?
    public fileprivate(set) var viewControllers: [UIViewController]!
    public fileprivate(set) var titles: [String]!
    fileprivate var previousIndex: Int = 0
    fileprivate var currentIndex: Int = 0
    
    // Scrollview in which the views are added to
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.bounces = true
        return scrollView
    }()
    
    // Menubar Anchored at the bottom of a navigationBar
    fileprivate lazy var menuBar: MenuBar = {
        let menuBar = MenuBar(titles: titles)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.delegate = self
        return menuBar
    }()
    
    public var configuration: MenuBarConfigurations? {
        didSet {
            guard let configuration = configuration else { return }
            menuBar.configuration = configuration
        }
    }
    
    public init(viewControllers: [UIViewController], titles: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        self.titles = titles
        scrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(viewControllers.count),
            height: scrollView.frame.height
        )
        addControllers(controllers: self.viewControllers)
        view.addSubview(menuBar)
        view.addSubview(scrollView)
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // MenuBar Constraints
        if #available(iOS 11.0, *) {
            let guide = self.view.safeAreaLayoutGuide
            menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            menuBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        }
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // ScrollView Constraints
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let xOffset : CGFloat = CGFloat(currentIndex) * size.width

        // Update Content size on Rotation
        scrollView.contentSize.width = size.width * CGFloat(viewControllers.count)
        self.scrollView.setContentOffset(CGPoint(x: xOffset, y: self.scrollView.contentOffset.y), animated: true)
    }

    fileprivate func addControllers(controllers: [UIViewController]) {
        for index in 0..<controllers.count {
            let controller = controllers[index]
            controller.willMove(toParent: self)
            addChild(controller)
            scrollView.addSubview(controller.view)

            // Constraints
            let leftAnchor = (index > 0) ? controllers[index - 1].view.rightAnchor : scrollView.leftAnchor
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            controller.view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            controller.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            controller.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            // Did Move
            controller.didMove(toParent: self)
        }
    }

    fileprivate func removeController(index: Int) {
        guard let controller = viewControllers?[index] else {
            return
        }
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        controller.didMove(toParent: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MenuBarController: UIScrollViewDelegate, MenuBarDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let currentPage = scrollView.contentOffset.x / scrollView.frame.size.width

        if ceil(currentPage) == currentPage {
            // Have Transitioned
            previousIndex = currentIndex
            currentIndex = Int(currentPage)
        }
        menuBar.update(contentOffset: offset, indexPath: IndexPath(row: currentIndex, section: 0))
        delegate?.menuBarController?(self, didScrollFrom: viewControllers[previousIndex], destinationController: viewControllers[currentIndex])
    }

    public func didSelectItem(indexPath: IndexPath) {
        previousIndex = currentIndex
        currentIndex = indexPath.row
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            let xOffset : CGFloat = CGFloat(indexPath.row) * self.scrollView.frame.width
            self.scrollView.setContentOffset(CGPoint(x: xOffset, y: self.scrollView.contentOffset.y), animated: false)
        })
    }
}
