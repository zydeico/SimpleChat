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
    private var itemSizeCache: [IndexPath: CGSize] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpNavigationBar()
        setUpCollectionView()
        setUpCollectionViewGestures()
        setUpTextView()
        setUpSendButton()
        setUpKeyboardNotifications()
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
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        layout.minimumLineSpacing = 0.0
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUpCollectionViewGestures() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        collectionView.addGestureRecognizer(gesture)
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
    
    private func setUpKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
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
        let targetSize = CGSize(width: view.frame.width * 0.7, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let text = viewModel.getCellViewModel(at: indexPath).text
        let boundingRect = NSString(string: text).boundingRect(with: targetSize,
                                                               options: .usesLineFragmentOrigin,
                                                               attributes: attributes,
                                                               context: nil)
        let size = CGSize(width: ceil(boundingRect.width),
                          height: ceil(boundingRect.height) + ChatCollectionViewCell.padding)
        itemSizeCache[indexPath] = size
        return size
    }
    
    private func getItemSize(at indexPath: IndexPath) -> CGSize {
        if let i = itemSizeCache.index(forKey: indexPath) {
            return itemSizeCache[i].value
        }
        return calculateItemSize(at: indexPath)
    }
    
    private func getCollectionViewSectionInsets() -> UIEdgeInsets {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.sectionInset
        }
        return .zero
    }
    
    @objc private func leftBarButtonTapped() {
        viewModel.tapBack()
    }
    
    @objc private func sendButtonTapped() {
        guard viewModel.isMessageValid(withText: textView.text) else {
            return
        }
        viewModel.sendMessage(withText: textView.text)
        textView.text = ""
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let offset = UIApplication.shared.windows.first(where: \.isKeyWindow)?.safeAreaInsets.bottom ?? 0.0
        bottomConstraint.constant = keyboardRect.height - offset
    }
    
    @objc private func keyboardWillHide() {
        bottomConstraint.constant = 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getItemSize(at: indexPath).height
        let insets = getCollectionViewSectionInsets()
        return CGSize(width: view.frame.width - (insets.left + insets.right), height: height)
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
        let width = getItemSize(at: indexPath).width
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        cell.setWidth(width)
        if viewModel.isSentByUser(at: indexPath) {
            cell.setOriginX(view.frame.width - width - getCollectionViewSectionInsets().right)
            cell.useVariantColor = true
        }
        return cell
    }
}
