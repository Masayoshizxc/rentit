//
//  ChatTableViewCell.swift
//  Rentit
//
//  Created by Eldiiar on 3/11/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.exampleImg()
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сдается юрта в аренду"
        label.font = R.font.commissionerMedium(size: heightComputed(14))
        return label
    }()
    
    private lazy var readImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.read()
        return imageView
    }()
    
    private lazy var latestMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Здравствуйте"
        label.textColor = R.color.grayish()
        label.font = R.font.commissionerRegular(size: heightComputed(12))
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.textColor = R.color.grayish()
        label.font = R.font.commissionerRegular(size: 12)
        return label
    }()
    
    private lazy var unreadLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.font = R.font.commissionerMedium(size: heightComputed(10))
        label.textAlignment = .center
        label.backgroundColor = R.color.blue()
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
//    private lazy var shadow : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = R.color.blue()
//        label.clipsToBounds = true
//        label.layer.cornerRadius = 8
//        label.alpha = 0.3
//        return label
//    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        addSubviews(
            avatarImage,
            titleLabel,
            readImage,
            latestMessageLabel,
            dateLabel,
            unreadLabel
        )
        
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(message: String) {
        latestMessageLabel.text = message
    }
    
    func setUpConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(38)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalTo(avatarImage.snp.right).offset(9)
            make.height.equalTo(heightComputed(15))
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.right.equalToSuperview().inset(16)
        }
        
        readImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(avatarImage.snp.right).offset(9)
            make.width.equalTo(widthComputed(14))
            make.height.equalTo(7.5)
        }
        
        latestMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(readImage.snp.right).offset(6)
            make.right.equalTo(unreadLabel.snp.right).offset(40)
            make.height.equalTo(heightComputed(13))
        }
        
        unreadLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(widthComputed(18))
            make.bottom.equalToSuperview().inset(13)
        }
        
//        shadow.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).offset(8)
//            make.right.equalToSuperview().inset(16)
//            make.width.equalTo(widthComputed(18))
//            //make.height.equalTo(heightComputed(14))
//            make.bottom.equalToSuperview().inset(12)
//        }
    }
}
