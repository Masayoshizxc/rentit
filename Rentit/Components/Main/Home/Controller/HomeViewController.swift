//
//  ViewController.swift
//  Rentit
//
//  Created by Adilet on 8/10/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var items = ["1", "2", "3", "4", "5", "6"]
    var ads = [AdsView]()
    var pop = [imagesForCollection]()
    var kat = [KategoryCell]()
    var act = [AdsView]()
    
    weak var coordinator: HomeCoordinator?
    private var ui = HomeView()
    private let viewModel:HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var searchImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "search")
        return img
    }()
    
    private lazy var sortImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "sort")
        return img
    }()
    
    func addShadow (toSh: UIView) {
        let shadow = UIBezierPath(roundedRect: toSh.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadow.cgPath
        layer0.shadowColor = UIColor(red: 0.506, green: 0.788, blue: 0.925, alpha: 0.1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 12
        layer0.shadowOffset = CGSize(width: 0, height: 2)
        layer0.bounds = toSh.bounds
        layer0.position = toSh.center
        toSh.layer.addSublayer(layer0)
    }
    
    private lazy var searchField: SearchField = {
        let field = SearchField()
        return field
    }()
    
    private lazy var searchFieldd: UITextField = {
        let field = UITextField()
        field.placeholder = "\tПоиск"
        field.leftViewMode = UITextField.ViewMode.always
        field.leftView?.backgroundColor = .red
        field.leftView?.contentMode = .center
        field.leftView?.frame.size.width = 100
        field.leftView?.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(field)
        }
        field.leftView?.addSubview(searchImage)
        field.leftView = UIImageView(image: UIImage(named: "search"))
        field.layer.cornerRadius = 25
        return field
    }()
    
    private lazy var filterButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "sort"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
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
    
    private lazy var kategoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var popularLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Популярные категории"
        lbl.font = UIFont(name: "Commissioner-SemiBold", size: 18)
        return lbl
    }()
    private lazy var popKategoryView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PopKatViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var adsLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Объявления"
        lbl.font = UIFont(name: "Commissioner-SemiBold", size: 18)
        return lbl
    }()
    
    private lazy var adsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.set(cell: AdsView.fetch())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AdsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var actualLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-SemiBold", size: 18)
        lbl.text = "Актуальное"
        return lbl
    }()
    
    private lazy var actualLabelDes : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Medium", size: 13)
        lbl.textColor = .gray
        lbl.text = "Самые просматриваемые объявления за неделю"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var actualView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AdsCollectionViewCell.self)
        return collectionView
    }()
    
    private lazy var usefulLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Полезное"
        lbl.font = UIFont(name: "Commissioner-SemiBold", size: 18)
        return lbl
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UsefulTableViewCell.self, forCellReuseIdentifier: "homePageCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var allB : UIButton = {
        let btn = UIButton()
        btn.setTitle("All", for: .normal)
        btn.setTitleColor(UIColor.standartBlue, for: .normal)
        btn.addTarget(self, action: #selector(allT), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        getProducts()
        
        ads(cell: AdsView.fetch())
        pop(cell: imagesForCollection.fetch())
        kat(cell: KategoryCell.forFetch())
        act(cell: AdsView.fetch())
        setUpSubviews()
        setUpConstraints()
        self.hideKeyboardWhenTappedAround()
        addShadow(toSh: searchField)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let app = UINavigationBarAppearance()
        app.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = app
        self.navigationController?.navigationBar.scrollEdgeAppearance = app
        self.navigationController?.navigationBar.compactAppearance = app
    }
    
    func getProducts() {
        viewModel.getProduct { result in
            switch result {
            case .success:
                self.adsView.reloadData()
            case .failure:
                print("Error")
            }
        }
    }
    
    func ads(cell: [AdsView]) {
        self.ads = cell
    }
    
    func pop(cell: [imagesForCollection]) {
        self.pop = cell
    }
    
    func kat(cell: [KategoryCell]) {
        self.kat = cell
    }
    
    func act(cell: [AdsView]) {
        self.act = cell
    }
    
    @objc func filterTapped() {
        let vc = FilterViewController()
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func disKey() {
        view.endEditing(true)
    }
    @objc func allT() {
        print("tapped")
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case kategoryView:
            return CGSize(width: 54, height: 80)
        case popKategoryView:
            return CGSize(width: 255, height: 128)
        case adsView:
            return CGSize(width: 162, height: 295)
        case actualView:
            return CGSize(width: 162, height: 295)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case kategoryView:
            return kat.count
        case popKategoryView:
            return pop.count
        case adsView:
            return viewModel.product.count
        case actualView:
            return act.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case kategoryView:
            let cell = collectionView.getReuseCell(CollectionViewCell.self, indexPath: indexPath)
            cell.layer.cornerRadius = cell.frame.size.width/2
            cell.mainImageView.image = kat[indexPath.row].image
            cell.mainImageView.backgroundColor = kat[indexPath.row].background
            cell.name.text = kat[indexPath.row].name
            return cell
        case popKategoryView:
            let cell = collectionView.getReuseCell(PopKatViewCell.self, indexPath: indexPath)
            cell.img.image = pop[indexPath.row].image
            return cell
        case adsView:
            let cell = collectionView.getReuseCell(AdsCollectionViewCell.self, indexPath: indexPath)
            cell.setUpData(model: viewModel.product[indexPath.row])
            cell.img.image = ads[0].image
            return cell
        case actualView:
            let cell = collectionView.getReuseCell(AdsCollectionViewCell.self, indexPath: indexPath)
            cell.img.image = ads[indexPath.row].image
            cell.rateLabel.text = "\(ads[indexPath.row].rate) (\(ads[indexPath.row].voted) отзывов)"
            cell.name.text = ads[indexPath.row].name
            cell.price.text = "\(ads[indexPath.row].price) KGS / \(ads[indexPath.row].price / 85) USD"
            cell.mode.text = ads[indexPath.row].mode
            return cell
        case kategoryView:
            let cell = collectionView.getReuseCell(CollectionViewCell.self, indexPath: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case adsView:
            let vc = CardViewController(id: viewModel.product[indexPath.row].id ?? 9)
            tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case actualView:
            let vc = CardViewController(id: 0)
            vc.itemImage.image = ads[indexPath.row].image
            vc.itemTitle.text = ads[indexPath.row].name
            vc.priceOfItem.text = "\(ads[indexPath.row].price) KGS / \(ads[indexPath.row].price / 85) USD"
            vc.addressLabel.text = "\(ads[indexPath.row].address)"
            vc.itemRate.text = "\(ads[indexPath.row].rate)"
            tabBarController?.navigationController?.pushViewController(vc, animated: true)
        case kategoryView:
            let vc = CategoryViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case popKategoryView:
            navigationController?.pushViewController(CategoryViewController(), animated: true)
        default:
            print("Empty")
        }
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homePageCell", for: indexPath) as! UsefulTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 211
    }
}

extension HomeViewController {
    func setUpSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(searchField,
                                  kategoryView,
                                  popularLabel,
                                  popKategoryView,
                                  adsLabel,
                                  adsView,
                                  actualLabel,
                                  actualLabelDes,
                                  actualView,
                                  usefulLabel,
                                  tableView,
                                  allB,
                                  filterButton)
    }
    
    func setUpConstraints() {
        searchField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(303)
            make.height.equalTo(48)
        }
        
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField)
            make.right.equalToSuperview().inset(18)
            make.width.equalTo(20)
            make.height.equalTo(18)
        }
        
        kategoryView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom).offset(16)
            make.height.equalTo(80)
        }
        
        popularLabel.snp.makeConstraints { make in
            make.top.equalTo(kategoryView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        popKategoryView.snp.makeConstraints { make in
            make.top.equalTo(popularLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(128)
        }
        
        adsLabel.snp.makeConstraints { make in
            make.top.equalTo(popKategoryView.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(16)
        }
        adsView.snp.makeConstraints { make in
            make.top.equalTo(adsLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(305)
        }
        actualLabel.snp.makeConstraints { make in
            make.top.equalTo(adsView.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(16)
        }
        actualLabelDes.snp.makeConstraints { make in
            make.top.equalTo(actualLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
        }
        actualView.snp.makeConstraints { make in
            make.top.equalTo(actualLabelDes.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(305)
        }
        usefulLabel.snp.makeConstraints { make in
            make.top.equalTo(actualView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(usefulLabel.snp.bottom).offset(41)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(455)
        }
        allB.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(usefulLabel)
        }
    }
}
