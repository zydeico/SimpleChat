//
//  ChatCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

protocol ChatCoordinatorDelegate: AnyObject {
    func didFinish(coordinator: ChatCoordinator)
}

final class ChatCoordinator: Coordinator {
    let router: Router
    
    weak var delegate: ChatCoordinatorDelegate?
    
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
        let vm = ChatViewModel()
        vm.delegate = self
        vc.viewModel = vm
        router.push(vc)
    }
}

// MARK: - View model delegates

extension ChatCoordinator: ChatViewModelDelegate {
    func didTapBack() {
        router.pop()
        delegate?.didFinish(coordinator: self)
    }
}
