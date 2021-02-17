//
//  AddressBook.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Contacts

final class AddressBook: AddressBookProvider {
    private let contactStore: CNContactStore
    
    init(contactStore: CNContactStore = CNContactStore()) {
        self.contactStore = contactStore
    }
    
    func getContacts() -> [Contact] {
        var contacts: [Contact] = []
        let keys = [ CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey ]
        do {
            try contactStore.enumerateContacts(with: .init(keysToFetch: keys as [CNKeyDescriptor]), usingBlock: { contact, _ in
                contacts.append(Contact(name: contact.givenName, lastName: contact.familyName, imageData: contact.imageData))
            })
        } catch {
            assertionFailure(error.localizedDescription)
        }
        return contacts
    }
}
