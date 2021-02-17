//
//  MockHomeViewModelDelegate.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/17.
//

import Foundation
@testable import SimpleChat

class MockHomeViewModelDelegate: HomeViewModelDelegate {
    var isDidSelectContactCalled = false
    var contactFromDidSelectContact: Contact?
    
    func didSelectContact(_ contact: Contact) {
        isDidSelectContactCalled = true
        contactFromDidSelectContact = contact
    }
}
