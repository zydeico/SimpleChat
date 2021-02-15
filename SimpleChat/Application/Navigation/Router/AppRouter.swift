//
//  AppRouter.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import UIKit

final class AppRouter: Router {
    let rootPresentable: Presentable
    
    private var rootViewController: UIViewController {
        guard let vc = rootPresentable as? UIViewController else {
            fatalError("The rootPresentable should be a UIViewController.")
        }
        return vc
    }
    
    private var navigationController: UINavigationController {
        guard let nc = rootViewController as? UINavigationController else {
            fatalError("The rootViewController should be a UINavigationController.")
        }
        return nc
    }
    
    init(rootPresentable: Presentable) {
        self.rootPresentable = rootPresentable
    }
    
    func setRoot(_ presentables: [Presentable]) {
        navigationController.setViewControllers(presentables.map(getViewController), animated: false)
    }
    
    func present(_ presentable: Presentable) {
        rootViewController.present(getViewController(from: presentable), animated: true)
    }
    
    func push(_ presentable: Presentable) {
        navigationController.pushViewController(getViewController(from: presentable), animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        rootViewController.dismiss(animated: true)
    }
    
    private func getViewController(from presentable: Presentable) -> UIViewController {
        guard let vc = presentable.toPresent() as? UIViewController else {
            fatalError("The presentable should be a UIViewController.")
        }
        return vc
    }
}
