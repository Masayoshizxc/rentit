//
//  ChatMessagesViewController.swift
//  Rentit
//
//  Created Eldiiar on 26/11/22.
//

import UIKit

struct Message {
    let title: String
    let data: String?
    let sender: Int
}

class ChatMessagesViewController: BaseViewController {
    
    let messageManager = MessageManager.shared
    let userDefaults = UserDefaultsService.shared
    
    var receiverId: Int?
    var conversationId: String?
    var arr = [Mess]()
    var type = 0
    var bottomConstraint = 28
    
    private lazy var productView: ProductView = {
        let view = ProductView()
        return view
    }()
    
    private lazy var messagesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SenderTableViewCell.self, forCellReuseIdentifier: "senderCell")
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var sendView: SendView = {
        let view = SendView()
        view.delegate = self
        return view
    }()
    
    private var ui = ChatMessagesView()
    private let viewModel:ChatMessagesViewModelProtocol
    
    init(viewModel: ChatMessagesViewModelProtocol = ChatMessagesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let titleView = TitleView()
        if type == 1 {
            titleView.supportView()
        }
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.threeDots(), style: .plain, target: self, action: #selector(didTapMore))
//        view = ui
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        messagesTableView.estimatedRowHeight = 79
        messagesTableView.rowHeight = UITableView.automaticDimension
        
        
        messageManager.getAllMessagesForConversation(with: conversationId ?? "", userId: "\(receiverId)") { result in
            switch result {
            case .success(let success):
                print(success)
                guard !success.isEmpty else {
                    return
                }
                DispatchQueue.main.async {
                    self.arr = success
                    self.messagesTableView.reloadData()
                    self.messagesTableView.scrollToRow(at: IndexPath(row: self.arr[self.arr.count - 1].messageModel.count - 1, section: self.arr.count - 1), at: .bottom, animated: true)
                }
            case .failure(let failure):
                print(failure)
            }
        }

        productView.isHidden = true
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapMore() {
        
    }
    
}

extension ChatMessagesViewController: SendProtocol {
    func didTapInputButton() {
        
        let sheet = UIAlertController(title: "Attach Media",
                                      message: "What would you like to attach?",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoInputAction()
        }))
        
        sheet.addAction(UIAlertAction(title: "Video", style: .default, handler: { _ in
            
        }))
        
        sheet.addAction(UIAlertAction(title: "Audio", style: .default, handler: { _ in
            
        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(sheet, animated: true)
     }
    
    func presentPhotoInputAction() {
        let sheet = UIAlertController(title: "Attach Photo",
                                      message: "What would you like to attach photo from?",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(sheet, animated: true)
    }
    
    func didTapSendButton(value: String) {
        guard let receiverId = receiverId else {
            print("There was an error with receiver Id", receiverId)
            return
        }
        messageManager.createNewConversations(with: String(receiverId), firstMessage: MessageModel(sender: userDefaults.getUserId(), messageId: conversationId ?? "", kind: .text(value))) { success in
            if success {
                print(success)
            }
        }
    }
}

extension ChatMessagesViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        //Upload Image
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = dateFormatter.string(from: Date())
        
        let fileName = "photo_message_\(conversationId ?? "")_\(date)"
        
        guard let imageData = image.pngData() else { return }
        StorageManger.shared.uploadMessagePicture(with: imageData, fileName: fileName) { [weak self] result in
            switch result {
            case .success(let urlString):
                print(urlString)
                self?.messageManager.createNewConversations(with: String(self?.receiverId ?? 0), firstMessage: MessageModel(sender: self?.userDefaults.getUserId() ?? 0, messageId: self?.conversationId ?? "", kind: .photo(urlString))) { success in
                    if success {
                        print(success)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
        //Send Message
    }
}

extension ChatMessagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr[section].messageModel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateDate = dateFormatter.date(from: arr[section].sentDate)
        dateFormatter.dateFormat = "MMMM yyyy"
        if dateDate != nil {
            let stringDate = dateFormatter.string(from: dateDate!)
            return stringDate
        }
        return arr[section].sentDate
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = R.font.commissionerRegular(size: 12)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! SenderTableViewCell
        cell.setUpData(model: arr[indexPath.section].messageModel[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 79
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChatMessagesViewController {
    
    private func setupSubviews() {
        view.addSubviews(
            productView,
            messagesTableView,
            sendView
        )
    }
    
    private func setupConstraints() {
        
        productView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(108)
            make.left.right.equalToSuperview()
            if productView.isHidden {
                make.height.equalTo(0)
            } else {
                make.height.equalTo(58)
            }
        }
        
        messagesTableView.snp.makeConstraints { make in
            make.top.equalTo(productView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(sendView.snp.top)
        }
        
        sendView.snp.makeConstraints { make in
            make.top.equalTo(messagesTableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(61)
            make.bottom.equalToSuperview().inset(28)
        }
    }
}
