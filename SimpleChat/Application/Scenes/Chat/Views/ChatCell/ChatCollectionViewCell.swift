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
    var useVariantColor: Bool? {
        didSet {
            if useVariantColor == true {
                mainView.backgroundColor = .systemBlue
                label.textColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayer()
        setUpMainView()
        setUpLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.backgroundColor = nil
        label.textColor = .label
    }
    
    func setWidth(_ width: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width + Self.padding, height: frame.height)
    }
    
    func setOriginX(_ x: CGFloat) {
        frame = CGRect(x: x - Self.padding, y: frame.origin.y, width: frame.width, height: frame.height)
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
