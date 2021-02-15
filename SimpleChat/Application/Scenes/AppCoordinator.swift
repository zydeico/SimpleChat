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
    
    func start() {
        startHome()
    }
    
    private func startHome() {
        let coordinator = HomeCoordinator(router: router)
        coordinatorAllocator.allocate(coordinator)
        coordinator.start()
    }
}
