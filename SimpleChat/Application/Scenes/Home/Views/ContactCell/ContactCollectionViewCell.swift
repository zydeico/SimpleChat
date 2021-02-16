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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayer()
    }
    
    private func setUpLayer() {
        layer.shadowColor = UIColor(named: "Shadow")?.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
    }
}
