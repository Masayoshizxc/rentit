//
//  MessageManager.swift
//  Rentit
//
//  Created by Eldiiar on 4/12/22.
//

import Foundation
import FirebaseFirestore
import Firebase

enum MessageResult {
    case success([MessageModel])
    case failure(Error)
}

struct Mess {
    let sentDate: String
    var messageModel: [MessageModel]
}

struct MessageModel {
    var sender: Int
    var messageId: String
    var sentDate: String?
    var kind: MessageKind
}


public enum MessageKind {

    case text(String)
    case photo(String)
//    case video(MediaItem)
//    case location(LocationItem)
//    case audio(AudioItem)
//    case contact(ContactItem)
}

extension MessageKind {
    var messageKindString: String {
        switch self {
        case .text(_):
            return "text"
        case .photo(_):
            return "photo"
        }
    }
}



class MessageManager {
    static let shared = MessageManager()
    let db = Firestore.firestore()
    //Creates new conversations
    
    func createNewConversations(with receiver: String, firstMessage: MessageModel, completion: @escaping (Bool) -> Void) {
        
        let conversationId = firstMessage.messageId
        let messageDate = firstMessage.sentDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: Date())
        var message = ""
        
        switch firstMessage.kind {
        case .text(let messageText):
            message = messageText
        case .photo(let photo):
            message = photo
            break
        }
        print("This is First Messsage", firstMessage.sender, receiver)
        db.collection("users").document(String(firstMessage.sender)).collection("conversation").document(receiver).setData([
            "id": conversationId,
            "receiver_id": receiver,
            "date_for_order": Date().timeIntervalSince1970,
            "latestMessage": [
                "date": dateString,
                "message": message,
                "is_read": false
            ]
        ])
        
        db.collection("users").document(receiver).collection("conversation").document(String(firstMessage.sender)).setData([
            "id": conversationId,
            "receiver_id": firstMessage.sender,
            "date_for_order": Date().timeIntervalSince1970,
            "latestMessage": [
                "date": dateString,
                "message": message,
                "is_read": false
            ]
        ])
        
        finishCreatingConversation(conversationID: conversationId,
                                   firstMessage: firstMessage,
                                   dateString: dateString,
                                   completion: completion)
    }
    
    private func finishCreatingConversation(conversationID: String, firstMessage: MessageModel, dateString: String, completion: @escaping (Bool) -> Void) {
        let messageDate = firstMessage.sentDate
        
        var message = ""
        switch firstMessage.kind {
        case .text(let messageText):
            message = messageText
        case .photo(let photo):
            message = photo
        }
        
        print("This is SENDER_ID", firstMessage.sender)
        let collectionMessage: [String: Any] = [
            "id": firstMessage.messageId,
            "content": message,
            "date": dateString,
            "date_for_order": Date().timeIntervalSince1970,
            "sender_id": firstMessage.sender,
            "is_read": false,
            "type" : firstMessage.kind.messageKindString
        ]
        
        db.collection("conversations").document("messages").collection(conversationID).addDocument(data: collectionMessage) { error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    //Fetches and returns all conversations
    func getAllConversation(for userId: String, completion: @escaping (Result<[ConversationModel], Error>) -> Void) {
        db.collection("users").document(userId).collection("conversation").order(by: "date_for_order", descending: true).addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            if let snapshotDocuments = querySnapshot?.documents {
                var conversation: [ConversationModel] = []
                for doc in snapshotDocuments {
                    print(doc.data())
//                    print("This is DOC", doc.data()["receiver_id"] as! String ?? "7")
                    let latestMessage = doc.data()["latestMessage"] as! [String: Any]
                    self.getUnreadMessages(with: doc.data()["id"] as! String, userId: userId) { number in
                        conversation.append(ConversationModel(id: doc.data()["id"] as! String,
                                                              receiverId: Int(doc.documentID) ?? 7,
                                                         numberOfUnreads: number,
                                                         latestMessage: LatestMessage(date: latestMessage["date"] as? String ?? "none",
                                                                                      message: latestMessage["message"] as! String,
                                                                                      isRead: latestMessage["is_read"] as! Bool)))
                        //Number of unreads doesn't refresh automatically
                        if conversation.count == snapshotDocuments.count {
                            completion(.success(conversation))
                        }
                        
                    }
                }
            }
        }
    }
    
    //Gets all messages for a given conversation
    func getAllMessagesForConversation(with conversationId: String, userId: String, completion: @escaping (Result<[Mess], Error>) -> Void) {
        db.collection("conversations").document("messages").collection(conversationId).order(by: "date_for_order").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            var count = 0
            var date = ""
            var conversations: [MessageModel] = []
            var conv: [Mess] = []
            
            for doc in querySnapshot!.documents {
                let mess = doc.data()
                guard let isRead = mess["is_read"] as? Bool,
                      let messageId = mess["id"] as? String,
                      let content = mess["content"] as? String,
                      let senderId = mess["sender_id"] as? Int,
                      let dateString = mess["date"] as? String,
                      let dateForOrder = mess["date_for_order"] else {
                          return
                      }
//                if isRead == false && senderPhone != userPhone {
//                    let collectionMessage: [String: Any] = [
//                        "id": messageId,
//                        "content": content,
//                        "date": dataString,
//                        "date_for_order": dateForOrder,
//                        "sender_phone": senderPhone,
//                        "is_read": true,
//                        "name": name
//                    ]
//
//                    print(collectionMessage, "It is this one")
//
//                    self.db.collection("conversations").document("messages").collection(id).document(doc.documentID).setData(collectionMessage) { error in
//                        guard error == nil else {
//                            return
//                        }
//                    }
//                }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateDate = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if  dateDate != nil {
                    let stringDate = dateFormatter.string(from: dateDate!)
                    if date != stringDate {
                        conv.append(Mess(sentDate: stringDate, messageModel: [MessageModel(sender: senderId,
                                                                                          messageId: messageId,
                                                                                          sentDate: dateString,
                                                                                          kind: .text(content))]))
                    } else {
                        print(conv.count, count)
                        print(stringDate, dateString)
                        conv[conv.count - 1].messageModel.append(
                            MessageModel(
                                sender: senderId,
                                messageId: messageId,
                                sentDate: dateString,
                                kind: .text(content)
                            )
                        )
                    }
                    date = stringDate
                }
                
                
                conversations.append(MessageModel(sender: senderId,
                                                  messageId: messageId,
                                                  sentDate: dateString,
                                                  kind: .text(content)))
                count += 1
                
            }
            print(conv.count)
            completion(.success(conv))
            
        }
    }
    
    func getUnreadMessages(with id: String, userId: String, completion: @escaping (Int) -> Void) {
        var number = 0
        db.collection("conversations").document("messages").collection(id).order(by: "date_for_order").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                return
            }
                        
            for doc in querySnapshot!.documents {
                let mess = doc.data()
                guard let isRead = mess["is_read"] as? Bool, let senderPhone = mess["sender_id"] as? Int else {
                          return
                }
                if isRead == false && senderPhone != Int(userId) {
                    number += 1
                }
            }
            completion(number)
        }
    }

    
}

struct ConversationModel {
    let id: String
    let receiverId: Int
    let numberOfUnreads: Int
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let message: String
    let isRead: Bool
}
