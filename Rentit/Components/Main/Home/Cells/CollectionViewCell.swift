//
//  CollectionViewCell.swift
//  MedTech
//
//  Created by Adilet on 15/6/22.
//

import UIKit
import SnapKit
// swiftlint:disable all
class CollectionViewCell: UICollectionViewCell {
    var cells = [KategoryCell]()
    
    static let reuseID = "HomeView"
    let shape = CAShapeLayer()
    
    lazy var mainImageView : UIImageView = {
        let imageView = UIImageView()
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 50.0/2.0
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = CGColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
//        imageView.backgroundColor = .purple
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.sizeToFit()
        return imageView
    }()
    lazy var name : UILabel = {
        let l = UILabel()
        l.textColor = UIColor(red: 0.506, green: 0.565, blue: 0.678, alpha: 1)
        l.font = .systemFont(ofSize: 11)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(mainImageView)
        contentView.addSubview(name)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpConstraints(){
        mainImageView.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.width.height.equalTo(45)
        }
        name.snp.makeConstraints{make in
            make.top.equalTo(mainImageView.snp.bottom).offset(8.53)
            make.width.equalTo(mainImageView)
        }
    }

//    func setBeforeDate(text: Int) {
//        self.mainImageView.layer.borderWidth = 0
//        self.mainImageView.layer.borderColor = UIColor.clear.cgColor
//        self.mainImageView.backgroundColor = UIColor(red: 1, green: 0.714, blue: 0.71, alpha: 1)
//        self.numbersOfWeeks.textColor = .white
//        numbersOfWeeks.text = String(text)
//    }
    
//    func fill(text: Int) {
//        numbersOfWeeks.text = String(text)
//        numbersOfWeeks.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
//        self.mainImageView.backgroundColor = .white
//    }
//
//    func addProgressBar(strokeEnd: CGFloat) {
//        let circlePath = UIBezierPath(arcCenter: center,
//                                      radius: frame.width / 2 - 1,
//                                      startAngle: -(.pi / 2),
//                                      endAngle: .pi * 2,
//                                      clockwise: true)
//
//
////        let trackShape = CAShapeLayer()
////        trackShape.path = circlePath.cgPath
////        trackShape.fillColor = UIColor.clear.cgColor
////        trackShape.strokeColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1).cgColor
////        trackShape.lineWidth = 2
////        layer.addSublayer(trackShape)
//
//        shape.path = circlePath.cgPath
//        shape.lineWidth = 2
//        shape.strokeColor = UIColor(red: 1, green: 0.714, blue: 0.71, alpha: 1).cgColor
//        shape.strokeEnd = strokeEnd
//        shape.fillColor = UIColor.clear.cgColor
//        layer.addSublayer(shape)
//    }
}

//extension UICollectionReusableView {
//    var identifier: String {
//        .init(describing: self)
//    }
//
//    static var identifier: String {
//        .init(describing: self)
//    }
//}
