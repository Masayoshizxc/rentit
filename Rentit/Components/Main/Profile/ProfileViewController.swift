//
//  ProfileViewController.swift
//  Rentit
//
//  Created Eldiiar on 13/11/22.
//

import UIKit
import Cosmos
import SwiftyMenuBar

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
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
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.user()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 38
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Элдана Карыбекова"
        label.font = R.font.commissionerSemiBold(size: heightComputed(18))
        return label
    }()
    
    private lazy var ratingLabel : UILabel = {
        let label = UILabel()
        label.text = "Рейтинг: 3.9"
        label.font = R.font.commissionerMedium(size: heightComputed(12))
        return label
    }()
    
    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.starSize = 10
        view.settings.starMargin = 2
        view.settings.starMargin = 3
        view.settings.emptyImage = R.image.empty()
        view.settings.filledImage = R.image.full()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var userStatus : UILabel = {
        let label = UILabel()
        label.text = "Профиль подтвержден"
        label.font = R.font.commissionerMedium(size: heightComputed(13))
        label.textColor = R.color.blue()
        return label
    }()
    
    private lazy var verifiedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.seal.fill")
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private lazy var followersLabel : UILabel = {
        let label = UILabel()
        label.text = "10 подписчиков"
        label.backgroundColor = UIColor(red: 0.953, green: 0.969, blue: 1, alpha: 1)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.font = R.font.commissionerMedium(size: heightComputed(12))
        return label
    }()
    
    private lazy var followedLabel : UILabel = {
        let label = UILabel()
        label.text = "22 подписки"
        label.backgroundColor = UIColor(red: 0.953, green: 0.969, blue: 1, alpha: 1)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.font = R.font.commissionerMedium(size: heightComputed(12))
        return label
    }()

    private lazy var cityLabel : UILabel = {
        let label = UILabel()
        label.text = "Город: Бишкек"
        label.font = R.font.commissionerMedium(size: heightComputed(11))
        return label
    }()
    
    private lazy var phoneLabel : UILabel = {
        let label = UILabel()
        label.text = "Номер телефона: +996 709 12 34 56"
        label.font = R.font.commissionerMedium(size: heightComputed(11))
        return label
    }()
    
    private lazy var tarifImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.tariff()
        return imageView
    }()
    
    private lazy var tarifLabel : UILabel = {
        let label = UILabel()
        label.text = "Тариф: стандарт"
        label.font = R.font.commissionerRegular(size: heightComputed(14))
        return label
    }()
    
    private lazy var balanceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.wallet()
        return imageView
    }()
    
    private lazy var balanceLabel : UILabel = {
        let label = UILabel()
        label.text = "Баланс: 79 сом"
        label.font = R.font.commissionerRegular(size: heightComputed(14))
        return label
    }()
    
    private lazy var menuBar: MenuBar = {
        let conf = MenuBarConfigurations()
        conf.itemsPerPage = 2.5
        conf.font = R.font.commissionerSemiBold(size: heightComputed(14))!
        conf.barColor = .white
        conf.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        conf.selectedColor = R.color.blue()!
        conf.sliderColor = R.color.blue()!
        
        let menu = MenuBar(
            titles: [
                "Активные",
                "На модерации",
                "Деактивированы"
            ],
            configuration: conf)
        return menu
    }()
    
    private lazy var productsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProfileCollectionViewCell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        return cv
    }()
    
    private var ui = ProfileView()
    private let viewModel:ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol = ProfileViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view = ui
        view.backgroundColor = .systemBackground
        title = "Профиль"
        
        setupSubviews()
        setupConstraints()
        getUserInfo()
        getProducts()
    }
    
    func getUserInfo() {
        viewModel.getUser { result in
            switch result {
            case .success:
                print("Success", result)
                self.titleLabel.text = "\(self.viewModel.user?.last_name ?? "") \(self.viewModel.user?.first_name ?? "")"
                self.phoneLabel.text = "Номер телефона: +\(self.viewModel.user?.phoneNumber ?? "")"
            case .failure:
                print("Failure")
            }
        }
    }
    
    func getProducts() {
        viewModel.getMyProducts { result in
            switch result {
            case .success:
                print("Success")
                DispatchQueue.main.async {
                    self.productsCollectionView.reloadData()
                    self.productsCollectionView.layoutIfNeeded()
                    let height = self.productsCollectionView.contentSize.height
                    print(height)
                    self.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + height - 400)
                    self.scrollView.contentSize = self.contentSize
                    self.containerView.frame.size = self.contentSize
                }
            case .failure:
                print("Error")
            }
        }
    }
    
    @objc func didTapMore() {
        coordinator?.goToSettings()
    }
}

extension ProfileViewController {
    
    private func setupSubviews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.share(), style: .plain, target: self, action: #selector(didTapMore))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: R.image.settings(), style: .plain, target: self, action: #selector(didTapMore)),
            UIBarButtonItem(image: R.image.notifications(), style: .plain, target: self, action: #selector(didTapMore))
        ]
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(
            profileImage,
            titleLabel,
            ratingLabel,
            ratingView,
            userStatus,
            verifiedImage,
            followersLabel,
            followedLabel,
            cityLabel,
            phoneLabel,
            tarifImage,
            tarifLabel,
            balanceImage,
            balanceLabel,
            menuBar,
            productsCollectionView
        )
    }
    
    private func setupConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(heightComputed(20))
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(76)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(heightComputed(27))
            make.left.equalTo(profileImage.snp.right).offset(20)
            make.right.equalToSuperview().inset(87)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        ratingView.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel.snp.centerY)
            make.left.equalTo(ratingLabel.snp.right).offset(3)
        }
        
        userStatus.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(3)
            make.left.equalTo(ratingLabel)
        }
        
        verifiedImage.snp.makeConstraints { make in
            make.top.equalTo(userStatus)
            make.left.equalTo(userStatus.snp.right).offset(4)
        }
        
        followersLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(widthComputed(156))
            make.height.equalTo(heightComputed(26))
        }
        
        followedLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(24)
            make.width.equalTo(widthComputed(156))
            make.height.equalTo(heightComputed(26))
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(followersLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(16)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().inset(16)
        }
        
        tarifImage.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        tarifLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tarifImage)
            make.left.equalTo(tarifImage.snp.right).offset(5)
        }
        
        balanceImage.snp.makeConstraints { make in
            make.top.equalTo(tarifLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(balanceImage)
            make.left.equalTo(balanceImage.snp.right).offset(5)
        }
        
        menuBar.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(46)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(heightComputed(40))
        }
        
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuBar.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2 - 29, height: heightComputed(295))
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.myProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(ProfileCollectionViewCell.self, indexPath: indexPath)
        cell.setUpData(model: viewModel.myProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CardViewController(id: viewModel.myProducts[indexPath.row].id ?? 9)
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
