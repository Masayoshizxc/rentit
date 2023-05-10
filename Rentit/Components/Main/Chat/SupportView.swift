//
//  SupportView.swift
//  Rentit
//
//  Created by Eldiiar on 3/11/22.
//

import UIKit

class SupportView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.support()
        return imageView
    }()

    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Техподдержка Rent It"
        label.textColor = R.color.blue()
        label.font = R.font.commissionerSemiBold(size: 16)
        return label
    }()
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "Мы ответим на все ваши вопросы"
        label.textColor = R.color.grayish()
        label.font = R.font.commissionerMedium(size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.whiteGray()
        layer.cornerRadius = 10
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension SupportView {
    
    private func setupSubviews() {
        addSubviews(
            imageView,
            titleLabel,
            descLabel
        )
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(18)
            make.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(imageView.snp.right).offset(12)
            make.height.equalTo(16)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel)
            make.height.equalTo(16)
        }
    }
}
