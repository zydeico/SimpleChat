//
//  AppCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class AppCoordinator {
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func showChats() {
        let contact = Contact(name: "", lastName: "", imageData: nil)
        startChat(with: contact)
    }
    
    private func startChat(with contact: Contact) {
        let coordinator = ChatCoordinator(router: router, contact: contact)
        coordinator.start()
    }
}
