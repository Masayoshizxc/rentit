//
//  CardViewController.swift
//  Rentit
//
//  Created Eldiiar on 16/11/22.
//

import UIKit

struct Fields {
    let title: String
    let value: String
}

class CardViewController: UIViewController {

    var ads = [AdsView]()
    var model = [Fields]()

    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1500)

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
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()

    lazy var itemImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cardimg")
        img.layer.cornerRadius = 0
        return img
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "1/10"
        label.textColor = R.color.forIcons()
        label.font = R.font.commissionerMedium(size: 10)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()

    private lazy var imageUnderGround: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private lazy var itemView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var itemTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Regular", size: 20)
        lbl.numberOfLines = 0
        lbl.textColor = .black
        return lbl
    }()

    lazy var priceOfItem: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-SemiBold", size: 20)
        lbl.numberOfLines = 0
        return lbl
    }()

    lazy var itemIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star")
        return img
    }()

    lazy var itemRate: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Regular", size: 26)
        lbl.text = "4.9"
        return lbl
    }()

    lazy var votedLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = .systemFont(ofSize: 17)
        lbl.text = "(146 voted)"
        return lbl
    }()

    lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Regular", size: 16)
        lbl.numberOfLines = 0
        lbl.text = "Бишкек, Свердловский район, улица Московская"
        return lbl
    }()

    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .standartBlue
        button.layer.cornerRadius = widthComputed(20)
        button.setTitle("Написать", for: .normal)
        button.titleLabel?.font = R.font.commissionerSemiBold(size: 16)
        button.addTarget(self, action: #selector(didTapWriteButton), for: .touchUpInside)
        return button
    }()

    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.standartBlue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.standartBlue.cgColor
        button.backgroundColor = .systemBackground
        button.setTitle("Позвонить", for: .normal)
        button.layer.cornerRadius = widthComputed(20)
        button.titleLabel?.font = R.font.commissionerSemiBold(size: 16)
        return button
    }()

    private lazy var tableView: TableView = {
        let tableView = TableView()
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.isUserInteractionEnabled = false
        return tableView
    }()

    private lazy var partOfDescription: UILabel = {
        let lbl = UILabel()
        lbl.text = "Описание"
        lbl.font = UIFont(name: "Commissioner-Medium", size: 20)
        lbl.textColor = .black
        return lbl
    }()

    lazy var actualDescription: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Regular", size: 13)
        lbl.numberOfLines = 0
        return lbl
    }()

    private lazy var compareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "toComment"), for: .normal)
        btn.tintColor = .standartBlue
        btn.setTitle("  Оставить отзыв", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Commissioner-SemiBold", size: 16)
        return btn
    }()

    private lazy var sameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Commissioner-Medium", size: 20)
        lbl.text = "Похожие объявления"
        return lbl
    }()

    private lazy var sameCollectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AdsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    // swiftlint:disable all
    private var ui = CardView()
    private let viewModel: CardViewModelProtocol

    var id = 0

    init(viewModel: CardViewModelProtocol = CardViewModel(), id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        ads(cell: AdsView.fetch())
        setupSubviews()
        setupConstraints()
        getProduct()
    }
    
    @objc func didTapWriteButton() {
        
        guard let userId = viewModel.product?.userId else { return }
        let userDefaults = UserDefaultsService.shared
        let id = "\(userId.byteSwapped)\(userDefaults.getUserId().byteSwapped)"
        var conversationId = "conversation_"
        for i in id.sorted() {
            conversationId += String(i)
        }
        print(conversationId)
        guard userDefaults.getUserId() != userId else {
            print("False")
            return
        }
        let vc = ChatMessagesViewController()
        vc.conversationId = conversationId
        vc.receiverId = userId
        print(userId)
        navigationController?.pushViewController(vc, animated: true)
    }

    func getProduct() {
        viewModel.getProduct(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.itemTitle.text = self.viewModel.product?.name
                    self.priceOfItem.text = "\(self.viewModel.product?.price ?? 0) KGS"
                    self.addressLabel.text = "\(self.viewModel.product?.address?.city ?? "") \(self.viewModel.product?.address?.street ?? "")"
                    self.actualDescription.text = self.viewModel.product?.description

                    guard let category = self.viewModel.product?.category, let product = self.viewModel.product else {
                        return
                    }
                    self.model.removeAll()
                    self.model.append(Fields(title: "Категория", value: category.parentCategory?.name ?? ""))
                    self.model.append(Fields(title: "Подкатегория", value: category.name ?? ""))
                    self.model.append(Fields(title: "Местоположение", value: product.address?.street ?? ""))
                    self.model.append(Fields(title: "Тип аренды", value: product.condition ?? ""))
                    self.model.append(Fields(title: "Доставка", value: "нет"))
                    self.tableView.reloadData()
                }
            case .failure:
                print("Error")
            }
        }
    }

    func ads(cell: [AdsView]) {
        self.ads = cell
    }

    func setUpNavigationBar() {
        let back = UIBarButtonItem(
            image: UIImage(named: "cardbac"),
            style: .plain, target: self, action: #selector(dis))
        let options = UIBarButtonItem(
            image: UIImage(named: "cardopt"),
            style: .plain, target: self, action: #selector(dis))
        let like = UIBarButtonItem(
            image: UIImage(named: "cardlik"),
            style: .plain, target: self, action: #selector(lik(sender:)))
        let upload = UIBarButtonItem(
            image: UIImage(named: "cardupl"),
            style: .plain, target: self, action: #selector(dis))
        self.navigationItem.setLeftBarButton(back, animated: true)
        self.navigationItem.setRightBarButtonItems([options, like, upload], animated: true)

        back.tintColor = .black
        options.tintColor = .black
        like.tintColor = .black
        upload.tintColor = .black
    }

    @objc func dis() {
        navigationController?.popViewController(animated: true)
    }
    @objc func lik(sender: UIBarButtonItem) {
        sender.image = UIImage(named: "collik2")
        sender.tintColor = .red
    }
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return model.count
        } else {
            return viewModel.product?.attributesList?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = R.font.commissionerMedium(size: 16)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Дополнительно"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath) as! CardTableViewCell // swiftlint:disable:this force_cast
        if indexPath.section == 0 {
            cell.setUpData(title: model[indexPath.row].title, value: model[indexPath.row].value)
        } else {
            guard let attributes = viewModel.product?.attributesList else { return cell }
            cell.setUpData(title: attributes[indexPath.row].attributeName ?? "",
                           value: attributes[indexPath.row].value ?? "")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}

extension CardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2 - 29, height: heightComputed(275))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(AdsCollectionViewCell.self, indexPath: indexPath)
        cell.img.image = ads[indexPath.row].image
        cell.rateLabel.text = "\(ads[indexPath.row].rate) (\(ads[indexPath.row].voted) отзывов)"
        cell.name.text = ads[indexPath.row].name
        cell.price.text = "\(ads[indexPath.row].price) KGS / \(ads[indexPath.row].price / 85) USD"
        cell.mode.text = ads[indexPath.row].mode
        return cell
    }
}

extension CardViewController {

    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(
            itemImage,
            counterLabel,
            itemTitle,
            itemIcon,
            itemRate,
            votedLabel,
            priceOfItem,
            addressLabel,
            writeButton,
            callButton,
            tableView,
            imageUnderGround,
            partOfDescription,
            actualDescription,
            compareButton,
            sameLabel,
            sameCollectionview)
        itemImage.addSubview(imageUnderGround)
    }

    private func setupConstraints() {
        itemImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(266)
        }

        counterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(itemImage).inset(26)
            make.centerX.equalTo(itemImage)
            make.width.equalTo(widthComputed(38))
            make.height.equalTo(heightComputed(16))
        }

        imageUnderGround.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(-3)
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }

        itemTitle.snp.makeConstraints { make in
            make.top.equalTo(imageUnderGround.snp.top).offset(20)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(itemIcon.snp.left).offset(5)
        }

        itemIcon.snp.makeConstraints { make in
            make.top.equalTo(imageUnderGround.snp.top).offset(27)
            make.right.equalToSuperview().inset(57)
            make.width.height.equalTo(26)
        }

        itemRate.snp.makeConstraints { make in
            make.centerY.equalTo(itemIcon)
            make.left.equalTo(itemIcon.snp.right).offset(4)
        }

        priceOfItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(itemTitle.snp.bottom).offset(6)
        }

        addressLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(priceOfItem.snp.bottom).offset(10)
        }

        writeButton.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(heightComputed(40))
            make.width.equalTo(widthComputed(165))
        }

        callButton.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(heightComputed(40))
            make.width.equalTo(widthComputed(165))
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(callButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }

        partOfDescription.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(tableView.snp.bottom).offset(16)
        }

        actualDescription.snp.makeConstraints { make in
            make.top.equalTo(partOfDescription.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }

        compareButton.snp.makeConstraints { make in
            make.top.equalTo(actualDescription.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(16)
        }

        sameLabel.snp.makeConstraints { make in
            make.top.equalTo(actualDescription.snp.bottom).offset(641)
            make.left.equalToSuperview().inset(16)
        }

        sameCollectionview.snp.makeConstraints { make in
            make.top.equalTo(sameLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
}
