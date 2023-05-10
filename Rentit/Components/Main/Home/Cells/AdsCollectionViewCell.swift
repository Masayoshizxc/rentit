//
//  AdsCollectionViewCell.swift
//  Rentit
//
//  Created by Adilet on 15/10/22.
//

import UIKit
import SnapKit
import SDWebImage

class AdsCollectionViewCell: UICollectionViewCell {
    static let reuseID = "AdsView"

    lazy var img: UIImageView = {
        let img = UIImageView()
        return img
    }()

    lazy var starImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star")
        return img
    }()

    lazy var rateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        lbl.font = UIFont(name: "Commissioner-Medium", size: 11)
        return lbl
    }()

    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()

    lazy var price: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 14)
        return lbl
    }()

    lazy var mode: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 10)
        lbl.textColor = .gray
        return lbl
    }()

    private lazy var like: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "collik"), for: .normal)
        button.addTarget(self, action: #selector(self.likeTapped(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var chat: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "colcha"), for: .normal)
        return button
    }()

    private lazy var options: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "colopt"), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpConstraints()
        //        contentView.addSubview(img)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = contentView.bounds

    }
    func setUpSubviews() {
        contentView.addSubviews(
            img,
            starImage,
            rateLabel,
            name,
            price,
            mode,
            like,
            chat,
            options
        )

    }

    func setUpData(model: Product) {
        name.text = model.name
        price.text = "\(model.price ?? 0) KGS"
        mode.text = model.condition
        rateLabel.text = "4.8 (5 отзывов)"
    }

    @objc func likeTapped(sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "collik") {
            sender.setImage(UIImage(named: "collik2"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "collik"), for: .normal)
        }
        print("pzdc")
    }
    func setUpConstraints() {
        img.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(162)
        }

        starImage.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(11.5)
            make.left.equalToSuperview().inset(11)
            make.width.height.equalTo(11)
        }

        rateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImage)
            make.left.equalTo(starImage.snp.right).offset(4)
        }

        like.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(8)
        }

        name.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(33)
            make.left.equalToSuperview().inset(10)
            make.width.equalToSuperview()
        }

        price.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(75)
            make.left.equalToSuperview().inset(10)
        }

        mode.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(98)
            make.left.equalToSuperview().inset(10)
        }
    }
}
