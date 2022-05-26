//
//  AppCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class AppCoordinator: Coordinator {
    
    let router: Router
    
    private let coordinatorAllocator: CoordinatorAllocatable
    
    init(router: Router, coordinatorAllocator: CoordinatorAllocatable = CoordinatorAllocator()) {
        self.router = router
        self.coordinatorAllocator = coordinatorAllocator
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
