//
//  HomeCoordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class HomeCoordinator: Coordinator {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let vc = HomeViewController.instantiate()
        let vm = HomeViewModel()
        vc.viewModel = vm
        router.setRoot([vc])
    }
}
