//
//  HomeViewModelTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/17.
//
//  swiftlint:disable weak_delegate

import XCTest
@testable import SimpleChat

final class HomeViewModelTests: XCTestCase {
    private let contacts: [Contact] = [
        Contact(name: "Name", lastName: "LastName", imageData: nil)
    ]
    private var sut: HomeViewModel!
    private var addressBook: MockAddressBook!
    private var contactsPermissionRequester: MockContactsPermissionRequester!
    private var delegate: MockHomeViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        contactsPermissionRequester = MockContactsPermissionRequester()
        addressBook = MockAddressBook()
        addressBook.contactsToReturn = contacts
        delegate = MockHomeViewModelDelegate()
        sut = HomeViewModel(contactsPermissionRequester: contactsPermissionRequester, addressBook: addressBook)
        sut.delegate = delegate
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        contactsPermissionRequester = nil
        addressBook = nil
        delegate = nil
    }
    
    func testRequestContactsPermissionTriggersIsContactsPermissionGrantedObservable() {
        var grantedPermissionResult: Bool?
        let expectation = self.expectation(description: "isContactsPermissionGranted triggered")
        
        contactsPermissionRequester.requestPermissionValueToReturn = true
        sut.isContactsPermissionGranted.bind { value in
            grantedPermissionResult = value
            expectation.fulfill()
        }
        
        sut.requestContactsPermission()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertNotNil(grantedPermissionResult)
    }
    
    func testGetContactsCallsAddressBookGetContactsMethod() {
        sut.getContacts()
        
        XCTAssertTrue(addressBook.isGetContactsCalled)
    }
    
    func testGetContactsTriggersIsContactsCountUpdatedObservable() {
        var contactsCount: Int?
        let expectation = self.expectation(description: "isContactsCountUpdated triggered")
        sut.isContactsCountUpdated.bind { c in
            contactsCount = c
            expectation.fulfill()
        }
        
        sut.getContacts()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertNotNil(contactsCount)
    }
    
    func testGetNumberOfItemsReturnsItemsCount() {
        sut.getContacts()
        
        XCTAssertEqual(sut.getNumberOfItems(in: 0), contacts.count)
    }
    
    func testGetCellViewModelReturnsContactCellViewModel() {
        let index = 0
        sut.getContacts()
        
        let model = sut.getCellViewModel(at: IndexPath(item: index, section: 0))
        
        XCTAssertEqual(model, ContactCellViewModel(contacts[index]))
    }
    
    func testSelectItemCallsDidSelectContactDelegateMethod() {
        let indexPath = IndexPath(item: 0, section: 0)
        sut.getContacts()
        
        let expectedItem = sut.getCellViewModel(at: indexPath)
        sut.selectItem(at: indexPath)
        
        XCTAssertTrue(delegate.isDidSelectContactCalled)
        XCTAssertEqual(expectedItem.asContact(), contacts[indexPath.item])
    }
    
    func testGetBackgroundViewModelReturnsBackgroundViewModel() {
        let model = sut.getBackgroundViewModel()
        
        XCTAssertEqual(model, BackgroundViewViewModel(title: NSLocalizedString("home.contacts.accessNotAllowed.title", comment: ""),
                                                  subtitle: NSLocalizedString("home.contacts.accessNotAllowed.description", comment: "")))
    }
}
