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
        setUpSubtitleLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setUpSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
    }
}
