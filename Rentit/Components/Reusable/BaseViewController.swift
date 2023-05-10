//
//  BaseViewController.swift
//  Rentit
//
//  Created by Eldiiar on 8/11/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.forIcons()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }

}
