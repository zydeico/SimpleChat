//
//  HomeViewController.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import UIKit

final class HomeViewController: UIViewController, StoryboardInstanceable {
    static let storyboardName: String = "Home"
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: HomeViewModel!
    
    private let cellReuseIdentifier = "ContactCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpCollectionView()
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = viewModel.title
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10.0
        layout.itemSize = CGSize(width: collectionView.frame.width - padding, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
        layout.minimumLineSpacing = 5.0
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }
}
