//
//  ChatCollectionViewCell.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/17.
//

import UIKit

final class ChatCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    static let padding: CGFloat = 30.0
    
    var viewModel: ChatCellViewModel? {
        didSet {
            setUpModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayer()
        setUpMainView()
        setUpLabel()
    }
    
    
    private func setUpModel() {
        label.text = viewModel?.text
    }
    
    private func setUpLayer() {
        layer.shadowColor = UIColor(named: "Shadow")?.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
    }
    
    private func setUpMainView() {
        mainView.layer.cornerRadius = 8.0
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor(named: "Border")?.cgColor
        mainView.clipsToBounds = true
    }

    private func setUpLabel() {
        label.numberOfLines = 0
    }
}
