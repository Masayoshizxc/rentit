//
//  CategoryViewController.swift
//  Rentit
//
//  Created by Adilet on 7/11/22.
//

import UIKit
import SnapKit
// swiftlint:disable all
class CategoryViewController: UIViewController {
    
    var ads = [AdsView]()
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

    private lazy var backButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "cardbac"), for: .normal)
        btn.addTarget(self, action: #selector(dis), for: .touchUpInside)
        return btn
    }()

    private lazy var searchField: SearchField = {
        let field = SearchField()
        return field
    }()

    private lazy var filterButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "sort"), for: .normal)
        return btn
    }()

    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Все категории"
        lbl.font = UIFont(name: "Commissioner-SemiBold", size: 18)
        return lbl
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AdsCollectionViewCell.self)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
        setUpConstraints()
        //        setUpNavBarBut()
        navigationItem.hidesBackButton = true
        hideKeyboardWhenTappedAround()
        set(cells: AdsView.fetch())
    }

    func setUpSubviews() {
        view.addSubviews(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(
            backButton,
            searchField,
            filterButton,
            titleLabel,
            collection)
    }

    func set (cells: [AdsView]) {
        self.ads = cells
    }

    //    func setUpNavBarBut(){
    //        self.navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
    //        let back = UIBarButtonItem(image: UIImage(named: "cardbac"), style: .plain, target: self, action: #selector(dis))
    //        self.navigationItem.setLeftBarButton(back, animated: true)
    //        back.tintColor = .black
    //    }
    // swiftlint:disable all
    @objc func dis(){
        self.dismiss(animated: true)
    }
    // swiftlint:enable all
    
    func setUpConstraints() {
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField)
            make.left.equalToSuperview().inset(16)
        }
        
        searchField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(-30)
            make.width.equalTo(303)
            make.height.equalTo(48)
        }
        
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField)
            make.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(searchField.snp.bottom).offset(16)
        }
        
        collection.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // swiftlint:disable all
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 295)
    }
    // swiftlint:enable all
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    // swiftlint:disable all
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(AdsCollectionViewCell.self, indexPath: indexPath)
        cell.img.image = ads[indexPath.row].image
        cell.rateLabel.text = "\(ads[indexPath.row].rate) (\(ads[indexPath.row].voted) отзывов)"
        cell.name.text = ads[indexPath.row].name
        cell.price.text = "\(ads[indexPath.row].price) KGS / \(ads[indexPath.row].price / 85) USD"
        cell.mode.text = ads[indexPath.row].mode
        return cell
    }
    // swiftlint:enable all

}
