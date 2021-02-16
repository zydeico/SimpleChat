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
        viewModel.requestContactsPermission()
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = viewModel.title
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10.0
        layout.itemSize = CGSize(width: view.frame.width - padding * 2.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
        layout.minimumLineSpacing = 5.0
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? ContactCollectionViewCell else {
            fatalError("Could not dequeue cell.")
        }
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}
