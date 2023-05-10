//
//  SellersView.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import UIKit

class SellersView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.illustration3()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Здесь пока ничего нет..."
        label.textColor = R.color.forIcons()
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "Добавляйте объявления в Избранное, чтобы посмотреть их позже"
        label.textColor = UIColor(red: 0.537, green: 0.584, blue: 0.675, alpha: 1)
        label.font = R.font.commissionerMedium(size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension SellersView {
    
    private func setupSubviews() {
        addSubviews(
            imageView,
            titleLabel,
            descLabel
        )
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(61)
            make.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }

        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
    }
}
