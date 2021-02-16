//
//  HomeCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class HomeCoordinator: Coordinator {
    let router: Router
    let coordinatorAllocator: CoordinatorAllocatable
    
    init(router: Router, coordinatorAllocator: CoordinatorAllocatable = CoordinatorAllocator()) {
        self.router = router
        self.coordinatorAllocator = coordinatorAllocator
    }
    
    func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let vc = HomeViewController.instantiate()
        let vm = HomeViewModel()
        vm.delegate = self
        vc.viewModel = vm
        router.setRoot([vc])
    }

// MARK: - View model delegates

extension HomeCoordinator: HomeViewModelDelegate {
    func didSelectContact() {
    }
}
}
