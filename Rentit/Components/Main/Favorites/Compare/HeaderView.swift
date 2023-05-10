//
//  HeaderView.swift
//  Rentit
//
//  Created by Eldiiar on 24/11/22.
//

import UIKit

class HeaderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.ads1()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.text = "1500 KGS / 18,45 USD"
        label.numberOfLines = 0
        label.font = R.font.commissionerSemiBold(size: 13)
        return label
    }()
    
    private lazy var ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.star()
        return imageView
    }()
    
    private lazy var ratingLabel : UILabel = {
        let label = UILabel()
        label.text = "4.8 (5 отзывов)"
        label.font = R.font.commissionerMedium(size: 11)
        return label
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Сдается юрта в аренду"
        label.numberOfLines = 0
        label.font = R.font.commissionerRegular(size: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            imageView,
            priceLabel,
            ratingImage,
            ratingLabel,
            titleLabel
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(model: Product) {
        priceLabel.text = "\(model.price ?? 0) KGS"
        titleLabel.text = model.name ?? ""
    }
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(widthComputed(48))
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview()
        }
        
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.height.width.equalTo(11)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingImage)
            make.left.equalTo(ratingImage.snp.right).offset(4)
            make.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview()
        }
    }
    
}
