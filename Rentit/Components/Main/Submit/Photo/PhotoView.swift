//
//  PhotoView.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit
import Alamofire

protocol PhotoViewProtocol {
    func didTapNextButton()
}

class PhotoView: UIView {
    
    var delegate: PhotoViewProtocol? = nil
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Наименование объявления"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "До Х символов"
        return field
    }()
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "Добавьте описание"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    lazy var descriptionView: UITextView = {
        let field = UITextView()
        field.text = "До 500 символов"
        field.font = R.font.commissionerRegular(size: 14)
        field.textColor = R.color.grayish()
        field.backgroundColor = R.color.whiteGray()
        field.alpha = 0.9
        field.layer.cornerRadius = 5
        field.autocorrectionType = .no
        return field
    }()
    
    private lazy var uploadTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Загрузите фотографии"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    private lazy var uploadDescLabel : UILabel = {
        let label = UILabel()
        label.text = "До 10 фотографий"
        label.font = R.font.commissionerRegular(size: 14)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 13
        layout.minimumInteritemSpacing = 13
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImagesCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var nextButton: YellowButton = {
        let button = YellowButton()
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
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
    
    @objc func didTapNextButton() {
        if delegate != nil {
            delegate?.didTapNextButton()
        }
    }
    
    
}

extension PhotoView {
    
    private func setupSubviews() {
        addSubviews(
            titleLabel,
            titleField,
            descLabel,
            descriptionView,
            uploadTitleLabel,
            uploadDescLabel,
            collectionView,
            nextButton
        )
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.left.right.equalToSuperview().inset(17)
        }
        
        titleField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(34)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(17)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(130)
        }
        
        uploadTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(18)
        }
        
        uploadDescLabel.snp.makeConstraints { make in
            make.top.equalTo(uploadTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(uploadDescLabel.snp.bottom).offset(26)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(17)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(tabbarHeight)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
}
