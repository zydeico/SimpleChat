//
//  ChatCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

final class ChatCoordinator {
    
    let router: Router
    
    private let contact: Contact
    
    init(router: Router, contact: Contact) {
        self.router = router
        self.contact = contact
    }
    
    func start() {
        showChatScreen()
    }
    
    private func showChatScreen() {
        let vc = ChatViewController.instantiate()
        let vm = ChatViewModel(contact: contact, autoResponder: ReverseAutoResponder())
        vc.viewModel = vm
        router.push(vc)
    }
}
