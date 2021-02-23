//
//  HomeViewModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didSelectContact(_ contact: Contact)
}

final class HomeViewModel {
    let title = NSLocalizedString("common.appTitle", comment: "")
    let isContactsPermissionGranted = Observable<Bool>()
    let isContactsCountUpdated = Observable<Int>()
    
    weak var delegate: HomeViewModelDelegate?
    
    private let contactsPermissionRequester: PermissionRequestable
    private let addressBook: AddressBookProvider
    private var items: [ContactCellViewModel] = []
    
    init(contactsPermissionRequester: PermissionRequestable, addressBook: AddressBookProvider) {
        self.contactsPermissionRequester = contactsPermissionRequester
        self.addressBook = addressBook
    }
    
    func requestContactsPermission() {
        contactsPermissionRequester.requestPermission(completionHandler: { [weak self] isGranted, _ in
            self?.isContactsPermissionGranted.value = isGranted
        })
    }
    
    func getContacts() {
        addressBook.getContacts { [weak self] contacts in
            self?.items = contacts.map { ContactCellViewModel($0) }
            self?.isContactsCountUpdated.value = contacts.count
        }
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ContactCellViewModel {
        return items[indexPath.item]
    }
    
    func selectItem(at indexPath: IndexPath) {
        let item = items[indexPath.item]
        delegate?.didSelectContact(item.asContact())
    }
}
