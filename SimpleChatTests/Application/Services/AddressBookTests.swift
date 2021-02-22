//
//  AddressBookTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/17.
//

import XCTest
@testable import SimpleChat

final class AddressBookTests: XCTestCase {
    private var sut: AddressBook!
    private var contactStore: MockCNContactStore!
    
    override func setUp() {
        super.setUp()
        contactStore = MockCNContactStore()
        sut = AddressBook(contactStore: contactStore)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        contactStore = nil
    }
    
    func testGetContactsWithAuthorizedStatusReturnsContacts() {
        MockCNContactStore.authorizationStatusToReturn = .authorized

        sut.getContacts { contacts in
            XCTAssertGreaterThan(contacts.count, 0)
        }
    }
}
