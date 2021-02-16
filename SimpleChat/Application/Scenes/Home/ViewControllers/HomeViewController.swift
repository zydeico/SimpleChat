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
}
