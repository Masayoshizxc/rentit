//
//  Extension + ScreenSize.swift
//  Sports.kg
//
//  Created by Eldiiar on 9/10/22.
//

import UIKit

extension NSObject {
    
    @objc var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    @objc var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    func widthComputed(_ value: CGFloat) -> CGFloat {
        screenWidth * value / 390
    }
    
    func heightComputed(_ value: CGFloat) -> CGFloat {
        screenHeight * value / 844
    }
    
    var tabbarHeight: CGFloat {
        UITabBarController().tabBar.frame.height
    }
}

extension UIViewController {
    var topBarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        if #available(iOS 13.0, *) {
            top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            top += UIApplication.shared.statusBarFrame.height
        }
        return top
    }
}
