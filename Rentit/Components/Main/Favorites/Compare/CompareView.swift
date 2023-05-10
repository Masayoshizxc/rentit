//
//  CompareView.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import UIKit

class CompareView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CompareCollectionViewCell.self)
        collectionView.isPagingEnabled = true
        collectionView.allowsSelection = false
        return collectionView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить список", for: .normal)
        button.titleLabel?.font = R.font.commissionerSemiBold(size: 20)
        button.setTitleColor(R.color.grayish(), for: .normal)
        button.backgroundColor = R.color.whiteGray()
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func didTapClearButton() {
        
    }
}

extension CompareView {
    
    private func setupSubviews() {
        addSubview(collectionView)
        addSubview(clearButton)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(156)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
}
