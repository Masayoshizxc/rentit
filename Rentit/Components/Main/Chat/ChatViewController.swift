//
//  ChatViewController.swift
//  Rentit
//
//  Created Eldiiar on 3/11/22.
//

import UIKit

class ChatViewController: BaseViewController, ChatViewProtocol {

    var conversations = [ConversationModel]()
    let messageManager = MessageManager.shared
    weak var coordinator: ChatCoordinator?
    private var ui = ChatView()
    private let viewModel: ChatViewModelProtocol
    
    init(viewModel: ChatViewModelProtocol = ChatViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сообщения"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.threeDots(), style: .plain, target: self, action: #selector(didTapMore))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.notifications(), style: .plain, target: self, action: #selector(didTapMore))
        view = ui
        ui.delegate = self
        ui.tableView.delegate = self
        ui.tableView.dataSource = self
        setupSubviews()
        setupConstraints()
        
        let userDefaults = UserDefaultsService.shared
        messageManager.getAllConversation(for: String(userDefaults.getUserId())) { result in
            switch result {
            case .success(let success):
                print(success)
                DispatchQueue.main.async {
                    self.conversations = success
                    self.ui.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func didTapSupport() {
        let vc = ChatMessagesViewController()
        vc.type = 1
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapMore() {
        
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        cell.setData(message: conversations[indexPath.row].latestMessage.message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatMessagesViewController()
        vc.conversationId = conversations[indexPath.row].id
        print("This is Receiver Id in TableView", conversations[indexPath.row].receiverId)
        vc.receiverId = conversations[indexPath.row].receiverId
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ChatViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
