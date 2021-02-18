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
    
    func tapBack() {
        delegate?.didTapBack()
    }
}
