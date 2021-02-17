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
    
    private let contact: ChatContactModel
    
    init(contact: Contact) {
        self.contact = ChatContactModel(contact)
    }
    
    func tapBack() {
        delegate?.didTapBack()
    }
}
