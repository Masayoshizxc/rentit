//
//  ProfileCollectionView.swift
//  Rentit
//
//  Created by Eldiiar on 25/11/22.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = R.image.ads1()
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        return img
    }()

    lazy var starImage: UIImageView = {
        let img = UIImageView()
        img.image = R.image.star()
        return img
    }()

    lazy var rateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        lbl.font = UIFont(name: "Commissioner-Medium", size: 11)
        lbl.text = "пока нет отзывов"
        return lbl
    }()

    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 16)
        lbl.text = "Сдается юрта в аренду"
        return lbl
    }()

    lazy var price: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.text = "1500 KGS / 18,45 USD"
        return lbl
    }()
    
    private lazy var viewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.view2()
        return imageView
    }()
    
    private lazy var viewLabel : UILabel = {
        let label = UILabel()
        label.text = "1302"
        label.font = R.font.commissionerMedium(size: 10)
        return label
    }()
    
    private lazy var likeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.like2()
        return imageView
    }()
    
    private lazy var likeLabel : UILabel = {
        let label = UILabel()
        label.text = "20"
        label.font = R.font.commissionerMedium(size: 10)
        return label
    }()
    
    private lazy var chatImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.envelope()
        return imageView
    }()
    
    private lazy var chatLabel : UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = R.font.commissionerMedium(size: 10)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds

    }
    func setUpSubviews() {
        contentView.addSubviews(
            imageView,
            starImage,
            rateLabel,
            name,
            price,
            viewImage,
            viewLabel,
            likeImage,
            likeLabel,
            chatImage,
            chatLabel
        )

    }

    func setUpData(model: MyProducts) {
        name.text = model.name
        price.text = "\(Int(model.price ?? 0)) KGS"
        rateLabel.text = "4.8 (5 отзывов)"
        viewLabel.text = String(model.views ?? 0)
        chatLabel.text = String(model.countOfChats ?? 0)
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
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(165)
        }

        starImage.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(11.5)
            make.left.equalToSuperview().inset(11)
            make.width.height.equalTo(11)
        }

        rateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImage)
            make.left.equalTo(starImage.snp.right).offset(4)
        }

        name.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(33)
            make.left.equalToSuperview().inset(10)
            make.width.equalToSuperview()
        }

        price.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(75)
            make.left.equalToSuperview().inset(10)
        }
        
        viewImage.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(13)
            make.left.equalTo(price)
            make.width.height.equalTo(16)
        }
        
        viewLabel.snp.makeConstraints { make in
            make.centerY.equalTo(viewImage)
            make.left.equalTo(viewImage.snp.right).offset(3)
        }
        
        likeImage.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(13)
            make.left.equalTo(viewLabel.snp.right).offset(16)
            make.width.height.equalTo(16)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeImage)
            make.left.equalTo(likeImage.snp.right).offset(3)
        }
        
        chatImage.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(13)
            make.left.equalTo(likeLabel.snp.right).offset(16)
            make.width.height.equalTo(16)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.centerY.equalTo(chatImage)
            make.left.equalTo(chatImage.snp.right).offset(3)
        }
    }
}
