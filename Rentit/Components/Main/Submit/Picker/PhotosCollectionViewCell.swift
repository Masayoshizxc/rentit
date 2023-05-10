//
//  PhotosCollectionViewCell.swift
//  Rentit
//
//  Created by Eldiiar on 10/11/22.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var representedAssetIdentifier: String!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func flash(count: String) {
        imageView.alpha = 0
        setNeedsDisplay()
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.imageView.alpha = 1
        })
    }
}
