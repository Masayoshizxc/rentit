//
//  SenderTableViewCell.swift
//  Rentit
//
//  Created by Eldiiar on 26/11/22.
//

import UIKit
import SnapKit

class SenderTableViewCell: UITableViewCell {
        
    lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.blue()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        //view.roundCorners([.topLeft, .topRight, .bottomLeft], radius: 10)
        return view
    }()
    
    private lazy var messageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = R.font.commissionerRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var readImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.chatRead()
        return imageView
    }()
    
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "17:09"
        label.textColor = .white
        label.font = R.font.commissionerRegular(size: 12)
        return label
    }()
    
    let userDefaults = UserDefaultsService.shared
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(messageView)
        messageView.addSubviews(
            messageLabel,
            readImage,
            timeLabel
//            mainImageView
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(model: MessageModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateDate = dateFormatter.date(from: model.sentDate ?? "")
        dateFormatter.dateFormat = "HH:mm"
        if dateDate != nil {
            let time = dateFormatter.string(from: dateDate!)
            timeLabel.text = time
        }
        
        switch model.kind {
        case let .text(data):
            messageLabel.text = data
        case .photo(let photo):
            messageLabel.isHidden = true
            mainImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(5)
                make.width.equalToSuperview()
                make.height.equalTo(200)
    //            make.bottom.equalToSuperview().inset(10)
            }
        }
        
        if model.sender != userDefaults.getUserId() {
            messageView.backgroundColor = R.color.grayViolet()
            messageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            messageLabel.textColor = .black
            timeLabel.textColor = R.color.grayish()
            readImage.isHidden = true
            messageView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.left.equalToSuperview().inset(16)
                make.right.equalToSuperview().inset(150)
            }
        } else {
            messageView.backgroundColor = R.color.blue()
            messageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
            messageLabel.textColor = .white
            timeLabel.textColor = .white
            readImage.isHidden = false
            messageView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.right.equalToSuperview().inset(16)
                make.left.equalToSuperview().inset(150)
            }
        }
    }
    
    func setUpConstraints() {
        messageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(150)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(12)
            //make.bottom.equalToSuperview().inset(30)
            make.height.greaterThanOrEqualToSuperview().inset(30)
        }
        
//        mainImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(5)
//            make.width.equalToSuperview()
//            make.height.greaterThanOrEqualToSuperview().inset(30)
//           make.bottom.equalToSuperview().inset(10)
//        }
        
        readImage.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.height.width.equalTo(20)
            make.right.equalTo(timeLabel.snp.left).inset(-5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    
}
