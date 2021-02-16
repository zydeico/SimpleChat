//
//  ChatCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

final class ChatCoordinator: Coordinator {
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        showChatScreen()
    }
    
    private func showChatScreen() {
        let vc = ChatViewController.instantiate()
        let vm = ChatViewModel()
        vc.viewModel = vm
        router.push(vc)
    }
    }
}
