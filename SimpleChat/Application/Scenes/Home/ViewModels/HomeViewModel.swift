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
    let title = NSLocalizedString("common.appTitle", comment: "")
    let contactsPermissionAlertTitle = NSLocalizedString("permissions.contacts.alert.title", comment: "")
    let contactsPermissionAlertMessage = NSLocalizedString("permissions.contacts.alert.message", comment: "")
    let contactsPermissionAlertButtonTitle = NSLocalizedString("common.ok", comment: "")
    let isContactsPermissionGranted = Observable<Bool>()
    
    weak var delegate: HomeViewModelDelegate?
    var shouldRequestManualContactsPermission: Bool {
        return contactsPermissionRequester.isPermissionRequested && !contactsPermissionRequester.isPermissionGranted
    }
    
    private let contactsPermissionRequester: PermissionRequestable
    private let addressBook: AddressBookProvider
    private var items: [ContactCellViewModel] = []
    
    init(contactsPermissionRequester: PermissionRequestable, addressBook: AddressBookProvider) {
        self.contactsPermissionRequester = contactsPermissionRequester
        self.addressBook = addressBook
    }
    
    func requestContactsPermission() {
        contactsPermissionRequester.requestPermission(completionHandler: { _, _ in })
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
