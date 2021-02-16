//
//  HomeViewModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didSelectContact()
}

final class HomeViewModel {
    let title = "Simple Chat"
    
    weak var delegate: HomeViewModelDelegate?
    
    private let contactsPermissionRequester: PermissionRequestable
    private var items: [ContactCellViewModel] = [
        ContactCellViewModel(name: "Name", lastName: "LastName", imageData: nil)
    ]
    
    init(contactsPermissionRequester: PermissionRequestable) {
        self.contactsPermissionRequester = contactsPermissionRequester
    
    func requestContactsPermission() {
        contactsPermissionRequester.requestPermission(completionHandler: { _, _ in })
    }
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ContactCellViewModel {
        return items[indexPath.item]
    }
    
    func selectItem(at indexPath: IndexPath) {
        delegate?.didSelectContact()
    }
}
