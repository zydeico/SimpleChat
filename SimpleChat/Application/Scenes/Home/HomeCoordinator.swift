//
//  HomeCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class HomeCoordinator: Coordinator {
    let router: Router
    
    private let coordinatorAllocator: CoordinatorAllocatable
    
    init(router: Router, coordinatorAllocator: CoordinatorAllocatable = CoordinatorAllocator()) {
        self.router = router
        self.coordinatorAllocator = coordinatorAllocator
    }
    
    func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let vc = HomeViewController.instantiate()
        let vm = HomeViewModel(contactsPermissionRequester: ContactsPermissionRequester(),
                               addressBook: AddressBook())
        vm.delegate = self
        vc.viewModel = vm
        router.setRoot([vc])
    }
    
    private func startChat(with contact: Contact) {
        let coordinator = ChatCoordinator(router: router, contact: contact)
        coordinator.delegate = self
        coordinatorAllocator.allocate(coordinator)
        coordinator.start()
    }
}

// MARK: - View model delegates

extension HomeCoordinator: HomeViewModelDelegate {
    func didSelectContact(_ contact: Contact) {
        startChat(with: contact)
    }
}

// MARK: - Coordinator delegates
extension HomeCoordinator: ChatCoordinatorDelegate {
    func didFinish(coordinator: ChatCoordinator) {
        coordinatorAllocator.deallocate(coordinator)
    }
}
