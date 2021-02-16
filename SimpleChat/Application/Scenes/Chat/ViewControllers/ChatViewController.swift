//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import UIKit

final class ChatViewController: UIViewController, StoryboardInstanceable {
    static var storyboardName: String = "Chat"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        let configuration = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(leftBarButtonTapped))
    }
    
    @objc private func leftBarButtonTapped() {
    }
}
