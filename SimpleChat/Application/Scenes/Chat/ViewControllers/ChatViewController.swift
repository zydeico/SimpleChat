//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import UIKit

final class ChatViewController: UIViewController, StoryboardInstanceable {
    static var storyboardName: String = "Chat"
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var sendButton: UIButton!
    
    var viewModel: ChatViewModel!
    
    private let cellReuseIdentifier = "ChatCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpCollectionView()
    }
    
    private func setUpNavigationBar() {
        let configuration = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.title = viewModel.title
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
        layout.minimumLineSpacing = 0.0
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    @objc private func leftBarButtonTapped() {
        viewModel.tapBack()
    }
}
