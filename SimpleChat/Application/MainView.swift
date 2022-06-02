//
//  MainView.swift
//  SimpleChat
//
//  Created by Juan Vazquez on 26/05/22.
//

import Foundation
import UIKit

class MainView: UIViewController {
    
    private var chatCoordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    private func showChatScreen() {
//        let vc = ChatViewController.instantiate()
//        let vm = ChatViewModel(contact: contact, autoResponder: ReverseAutoResponder())
//        vc.viewModel = vm
//        router?.push(vc)
//    }
    
    private func showChats() {
        let privateContact = Contact(name: "", lastName: "", imageData: nil)
        let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
        let viewModel = ChatViewModel(contact: privateContact, autoResponder: ReverseAutoResponder())
        vc.viewModel = viewModel
        self.present(vc, animated: true)
    }
    
    @IBAction func showChats(_ sender: Any) {
        showChats()
    }
}
