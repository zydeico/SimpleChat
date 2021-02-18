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
    private var items: [ChatCellViewModel] = []
    
    init(contact: Contact) {
        self.contact = ChatContactModel(contact)
    }
    
    
    func getCellViewModel(at indexPath: IndexPath) -> ChatCellViewModel {
        return items[indexPath.item]
    }
    func tapBack() {
        delegate?.didTapBack()
    }
}
