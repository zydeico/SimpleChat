//
//  ContactsPermissionRequester.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Contacts

final class ContactsPermissionRequester: PermissionRequestable {
    private let contactStoreType: CNContactStore.Type
    private let contactStore: CNContactStore
    private let contactStoreEntityType: CNEntityType = .contacts
    
    var isPermissionRequested: Bool {
        switch contactStoreType.authorizationStatus(for: contactStoreEntityType) {
        case .authorized,
             .denied,
             .restricted:
            return true
        case .notDetermined:
            return false
        @unknown default:
            fatalError("Undefined status for CNContactStore")
        }
    }
    
    var isPermissionGranted: Bool {
        switch contactStoreType.authorizationStatus(for: contactStoreEntityType) {
        case .authorized:
            return true
        case .denied,
             .notDetermined,
             .restricted:
            return false
        @unknown default:
            fatalError("Undefined status for CNContactStore")
        }
    }
    
    init(contactStoreType: CNContactStore.Type = CNContactStore.self, contactStore: CNContactStore = CNContactStore()) {
        self.contactStoreType = contactStoreType
        self.contactStore = contactStore
    }
    
    func requestPermission(completionHandler: @escaping (Bool, Error?) -> Void) {
        contactStore.requestAccess(for: contactStoreEntityType, completionHandler: completionHandler)
    }
}
