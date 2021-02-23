//
//  BackgroundView.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/23.
//

import UIKit

final class BackgroundView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
}
