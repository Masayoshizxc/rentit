//
//  PhotoViewController.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import UIKit
import Alamofire
// swiftlint:disable all
class PhotoViewController: BaseViewController, PhotoViewProtocol {
    
    var model = [String:Any]()
    var images: [UIImage] = [R.image.photo()!]
    
    weak var coordinator: PostProductCoordinator?
    
    private lazy var ui = PhotoView()
    private let viewModel:PhotoViewModelProtocol
    
    
    init(viewModel: PhotoViewModelProtocol = PhotoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новое объявление"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сбросить", style: .plain, target: self, action: #selector(didTapReset))
        navigationItem.rightBarButtonItem?.tintColor = .black
        view.addSubview(scrollView)
        ui.frame.size = contentSize
        scrollView.addSubview(ui)
        //view = ui
        ui.delegate = self
        ui.collectionView.delegate = self
        ui.collectionView.dataSource = self
        ui.descriptionView.delegate = self
        ui.titleField.delegate = self
    }
    
    func didTapNextButton() {
        var imagesData = [Data]()
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
            imagesData.append(imageData)
        }
        print("Button is pressed")
        coordinator?.goToInfo(model: model, imagesData: imagesData)
    }
    
    @objc func didTapReset() {
        print("Reset button tapped!!!")
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SendingImagesProtocol {
    func sendData(data: [UIImage]) {
        DispatchQueue.main.async {
            self.images = data
            if data.isEmpty {
                self.images.append(R.image.photo()!)
            }
            self.ui.collectionView.reloadData()
            self.ui.collectionView.layoutIfNeeded()
            let height = self.ui.collectionView.contentSize.height
            self.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + height - self.heightComputed(100))
            self.scrollView.contentSize = self.contentSize
            self.ui.frame.size = self.contentSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(ImagesCollectionViewCell.self, indexPath: indexPath)
        cell.setUpData(images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2 - 24, height: view.frame.size.width / 2 - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        model["description"] = ui.descriptionView.text
        let vc = PhotoPickerViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PhotoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == R.color.grayish() {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        model["description"] = textView.text
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        let newLength = text.count + string.count - range.length
//        return newLength <= 10
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "До 500 символов "
            textView.textColor = R.color.grayish()
        }
    }
    
}

extension PhotoViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        model["name"] = textField.text
    }
}

extension PhotoViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
