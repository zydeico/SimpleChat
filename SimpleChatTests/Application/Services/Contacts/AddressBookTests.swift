//
//  AddressBookTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/17.
//

import XCTest
@testable import SimpleChat

final class AddressBookTests: XCTestCase {
    var sut: AddressBook!
    var contactStore: MockCNContactStore!
    
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
    
    func testGetContactsWithAuthorizedStatusCallsDependencyMethod() {
        MockCNContactStore.authorizationStatusToReturn = .authorized
        
        _ = sut.getContacts()
        
        XCTAssertTrue(contactStore.isEnumerateContactsCalled)
    }
    
    func testGetContactsWithAuthorizedStatusReturnsContacts() {
        MockCNContactStore.authorizationStatusToReturn = .authorized

        XCTAssertGreaterThan(sut.getContacts().count, 0)
    }
}
