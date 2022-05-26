//
//  AppDelegate.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var chatCoordinator: AppCoordinator?
    private var rootViewController: Presentable {
        guard let vc = window?.rootViewController else {
            fatalError("The window has not been setup.")
        }
        return vc
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        startApp()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
    }
    
    private func startApp() {
        chatCoordinator = AppCoordinator(router: AppRouter(rootPresentable: rootViewController))
        chatCoordinator?.showChats()
    }
}
