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
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: ChatViewModel!
    
    private let cellReuseIdentifier = "ChatCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpCollectionView()
        setUpTextView()
        setUpSendButton()
        setUpKeyboardToolbar()
        bind()
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUpTextView() {
        textView.text = ""
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor(named: "Border")?.cgColor
    }
    
    private func setUpSendButton() {
        let configuration = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: configuration)
        sendButton.setImage(image, for: .normal)
        sendButton.setTitle("", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    private func setUpKeyboardToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
    }
    
    private func bind() {
        viewModel.isMessageCountUpdated.bind { [weak self] totalMessages in
            guard let total = totalMessages else {
                return
            }
            self?.collectionView.reloadData()
            self?.collectionView.scrollToItem(at: IndexPath(item: total - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    private func calculateItemSize(at indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width * 0.7, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let text = viewModel.getCellViewModel(at: indexPath).text
        let boundingRect = NSString(string: text).boundingRect(with: size,
                                                               options: .usesLineFragmentOrigin,
                                                               attributes: attributes,
                                                               context: nil)
        let height = ceil(boundingRect.height)
        let width = ceil(boundingRect.width)
        return CGSize(width: width, height: height + ChatCollectionViewCell.padding)
    }
    
    @objc private func leftBarButtonTapped() {
        viewModel.tapBack()
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc private func sendButtonTapped() {
        viewModel.sendMessage(withText: textView.text)
        textView.text = ""
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = calculateItemSize(at: indexPath).height
        return CGSize(width: view.frame.width, height: height)
    }
}

// MARK: - UICollectionViewDataSource

extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? ChatCollectionViewCell else {
            fatalError("Could not dequeue cell.")
        }
        let width = calculateItemSize(at: indexPath).width
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        cell.setWidth(width)
        if viewModel.getSentByUser(at: indexPath) {
            cell.setOriginX(view.frame.width - width)
        }
        return cell
    }
}
