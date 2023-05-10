//
//  TitleView.swift
//  Rentit
//
//  Created by Eldiiar on 26/11/22.
//

import UIKit

class TitleView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.person()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Эльдар Мусабаев"
        label.font = R.font.commissionerMedium(size: 16)
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Был в сети в 13:00"
        label.textColor = R.color.grayish()
        label.font = R.font.commissionerRegular(size: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(
            imageView,
            titleLabel,
            descLabel
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func supportView() {
        imageView.image = R.image.support()
        titleLabel.text = "Чат поддержки"
        titleLabel.textColor = R.color.blue()
        descLabel.text = "Мы ответим на все ваши вопросы"
    }
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(-5)
            make.left.equalTo(imageView.snp.right).offset(10)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(imageView.snp.right).offset(10)
        }
    }

}
