//
//  MockAddressBook.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/17.
//

import Foundation
@testable import SimpleChat

class MockAddressBook: AddressBookProvider {
    var contactsToReturn: [Contact]!
    var isGetContactsCalled = false
    
    func getContacts(completionHandler: @escaping ([Contact]) -> Void) {
        isGetContactsCalled = true
        completionHandler(contactsToReturn)
    }
}
