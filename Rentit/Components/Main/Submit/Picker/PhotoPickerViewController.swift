//
//  PhotoPickerViewController.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit
import Photos

protocol SendingImagesProtocol {
    func sendData(data: [UIImage])
}

class PhotoPickerViewController: BaseViewController {
    
    var delegate: SendingImagesProtocol? = nil
    
    private lazy var photos = PhotoPickerViewController.loadPhotos()
    private lazy var imageManager = PHCachingImageManager()
    
    var images = [UIImage]()
    
    var count = 0
    
    private lazy var thumbnailSize: CGSize = {
        let cellSize = (photosCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return CGSize(width: cellSize.width * UIScreen.main.scale,
                      height: cellSize.height * UIScreen.main.scale)
    }()
    
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allPhotosOptions)
    }
    
    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var ui = PhotoPickerView()
    private let viewModel:PhotoPickerViewModelProtocol
    
    init(viewModel: PhotoPickerViewModelProtocol = PhotoPickerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор фотографии"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didEndChoosing))
        view = ui
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didEndChoosing() {
        if self.delegate != nil {
            self.delegate?.sendData(data: images)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension PhotoPickerViewController {
    
    private func setupSubviews() {
        view.addSubview(photosCollectionView)
    }
    
    private func setupConstraints() {
        photosCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(18)
        }
    }
}

extension PhotoPickerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let asset = photos.object(at: indexPath.item)
        let cell = collectionView.getReuseCell(PhotosCollectionViewCell.self, indexPath: indexPath)
        
        cell.representedAssetIdentifier = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.imageView.image = image
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = photos.object(at: indexPath.item)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell {
            guard count < 10 else { return }
            count += 1
            title = "Выбранных фото: \(count)"
            cell.flash(count: String(count))
        }
        
        imageManager.requestImage(for: asset, targetSize: view.frame.size, contentMode: .aspectFill, options: nil, resultHandler: { [weak self] image, info in
            guard let image = image, let info = info else { return }
            
            if let isThumbmail = info[PHImageResultIsDegradedKey as NSString] as? Bool, !isThumbmail {
                self?.images.append(image)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 3.7, height: view.frame.size.width / 3.7)
    }
}
