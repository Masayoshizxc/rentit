//
//  FilterViewController.swift
//  Rentit
//
//  Created by Adilet on 11/11/22.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 800)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var firstTable: UITableView = {
        let t = UITableView()
        t.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.reuseID)
        t.delegate = self
        t.dataSource = self
        t.rowHeight = UITableView.automaticDimension
        t.isScrollEnabled = false
        
        return t
    }()
    private lazy var filteview: UIView = {
        let v = UIView()
        
        return v
    }()
    private lazy var lv: UILabel = {
        let l = UILabel()
        l.text = "Цена"
        l.textColor = .grayTabBar
        return l
    }()
    private lazy var frpr : UITextField = {
        let t = UITextField()
        t.placeholder = "Цена от"
        t.backgroundColor = UIColor(red: 243/255, green: 244/255, blue: 247/255, alpha: 1)
        return t
    }()
    private lazy var unpr : UITextField = {
        let t = UITextField()
        t.placeholder = "Цена до"
        t.backgroundColor = UIColor(red: 243/255, green: 244/255, blue: 247/255, alpha: 1)
        return t
    }()
    
    private lazy var secondTable: UITableView = {
        let t = UITableView()
        t.register(SecondTableViewCell.self, forCellReuseIdentifier: "cell2")
        t.delegate = self
        t.dataSource = self
        t.rowHeight = UITableView.automaticDimension
        t.isScrollEnabled = false
        return t
    }()
    private lazy var som: UIButton = {
        let b = UIButton()
        b.setTitle("  Сомы", for: .normal)
        b.setTitleColor(UIColor.grayTabBar, for: .normal)
        b.setImage(UIImage(named: "selected"), for: .normal)
        b.setImage(UIImage(named: "unselected"), for: .selected)
        b.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
        b.contentMode = .center
        return b
    }()
    private lazy var dol: UIButton = {
        let b = UIButton()
        b.setTitle("  Доллары", for: .normal)
        b.setImage(UIImage(named: "unselected"), for: .normal)
        b.setImage(UIImage(named: "selected"), for: .selected)
        b.contentMode = .center
        b.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
        return b
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фильтр"
        view.backgroundColor = .white
        setUpNavBarBut()
        setUpSubviews()
        setUpConstraints()
        hideKeyboardWhenTappedAround()
    }
    func setUpNavBarBut() {
        let back = UIBarButtonItem(image: UIImage(named: "cardbac"), style: .plain, target: self, action: #selector(dis))
        let clear = UIBarButtonItem(title: "Сбросить все", style: .plain, target: self, action: nil)
        clear.tintColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        self.navigationItem.setLeftBarButton(back, animated: true)
        self.navigationItem.setRightBarButton(clear, animated: true)
    }
    func setUpSubviews() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(containerView)
        containerView.addSubviews(firstTable, filteview)
        filteview.addSubviews(lv, frpr, unpr, som, dol)
        
    }
    @objc func tap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func dis() {
        navigationController?.popViewController(animated: true)
    }
    
    func setUpConstraints() {
        firstTable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview()
            make.height.equalTo(150)
        }
        filteview.snp.makeConstraints { make in
            make.top.equalTo(firstTable.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(134)
            
        }
        lv.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview()
        }
        frpr.snp.makeConstraints { make in
            make.width.equalTo(165)
            make.height.equalTo(36)
            make.left.equalToSuperview()
            make.top.equalTo(lv.snp.bottom).offset(10)
        }
        unpr.snp.makeConstraints { make in
            make.centerY.equalTo(frpr)
            make.width.equalTo(165)
            make.height.equalTo(36)
            make.left.equalTo(frpr.snp.right).offset(13)
            
        }
        som.snp.makeConstraints { make in
            make.centerX.equalTo(frpr)
            make.top.equalTo(frpr.snp.bottom).offset(16)
        }
        dol.snp.makeConstraints { make in
            make.centerX.equalTo(unpr)
            make.top.equalTo(unpr.snp.bottom).offset(16)
        }
    }
    
}

extension FilterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case firstTable:
            return 2
        case secondTable:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        switch
        switch tableView {
        case firstTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.reuseID, for: indexPath) as! FirstTableViewCell
            if indexPath.row == 0 {
                cell.setUpData(titleLabel: "Категория")
            } else {
                cell.setUpData(titleLabel: "Город или регион")
            }
            
            return cell
        case secondTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! SecondTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
