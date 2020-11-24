//
//  ChatViewController.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/24.
//

import UIKit
import MessageKit

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender : SenderType {
    var photoURL: String
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    
    private var messages = [Message]()
    
    private let selfSender = Sender(
        photoURL: "",
        senderId: "1",
        displayName: "Joe smith"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        SetUpMessages()
        
    }
    
    // MARK: - SetUP
    private func SetUpMessages() {
        
        messages.append(Message(
                            sender: selfSender,
                            messageId: "1",
                            sentDate: Date(),
                            kind: .text("Hello, wolrd message")
        ))
        
        messages.append(Message(
                            sender: selfSender,
                            messageId: "1",
                            sentDate: Date(),
                            kind: .text("Hello, wolrd message Hello, wolrd message")
        ))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

extension ChatViewController: MessagesLayoutDelegate, MessagesDataSource, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
