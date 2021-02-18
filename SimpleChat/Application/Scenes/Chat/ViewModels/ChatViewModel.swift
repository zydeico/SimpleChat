//
//  ChatViewModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

protocol ChatViewModelDelegate: AnyObject {
    func didTapBack()
}

final class ChatViewModel {
    let isMessageCountUpdated = Observable<Int>()
    weak var delegate: ChatViewModelDelegate?
    var title: String {
        return contact.name
    }
    
    private let contact: ChatContactModel
    private var items: [ChatModel] = []
    
    init(contact: Contact) {
        self.contact = ChatContactModel(contact)
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func getSentByUser(at indexPath: IndexPath) -> Bool {
        return items[indexPath.item].isSentByUser
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ChatCellViewModel {
        return ChatCellViewModel(items[indexPath.item])
    }
    
    func sendMessage(text: String) {
        let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
        addUserMessage(text: t)
        isMessageCountUpdated.value = items.count
        scheduleAutoReplyMessage(withText: t)
    }
    
    private func addUserMessage(text: String) {
        items.append(ChatModel(message: text, isSentByUser: true))
    }
    
    private func addAutoReplyMessage(text: String) {
        items.append(ChatModel(message: text, isSentByUser: false))
    }
    
    private func scheduleAutoReplyMessage(withText text: String) {
        let seconds = Double(arc4random_uniform(5))
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + seconds, execute: { [weak self] in
            self?.addAutoReplyMessage(text: String(text.reversed()))
            self?.isMessageCountUpdated.value = self?.items.count
        })
    }
    
    func tapBack() {
        delegate?.didTapBack()
    }
}
