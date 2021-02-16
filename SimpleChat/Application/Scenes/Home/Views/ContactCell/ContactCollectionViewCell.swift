//
//  ContactCollectionViewCell.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/15.
//

import UIKit

final class ContactCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
}
