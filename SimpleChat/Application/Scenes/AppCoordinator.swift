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
    
    func startChat() {
        let contact = Contact(name: "", lastName: "", imageData: nil)
        let coordinator = ChatCoordinator(router: router, contact: contact)
        coordinator.start()
    }
}
