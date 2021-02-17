//
//  ContactsPermissionRequesterTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/16.
//

import XCTest
@testable import SimpleChat

final class ContactsPermissionRequesterTests: XCTestCase {
    private var sut: ContactsPermissionRequester!
    private var contactStore: MockCNContactStore!
    
    override func setUp() {
        super.setUp()
        contactStore = MockCNContactStore()
        sut = ContactsPermissionRequester(contactStoreType: MockCNContactStore.self, contactStore: contactStore)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        contactStore = nil
    }
    
    func testIsPermissionRequestedWithAuthorizedStatusReturnsTrue() {
        MockCNContactStore.authorizationStatusToReturn = .authorized
        
        XCTAssertTrue(sut.isPermissionRequested)
    }
    
    func testIsPermissionRequestedWithDeniedStatusReturnsTrue() {
        MockCNContactStore.authorizationStatusToReturn = .denied
        
        XCTAssertTrue(sut.isPermissionRequested)
    }
    
    func testIsPermissionRequestedWithRestrictedStatusReturnsTrue() {
        MockCNContactStore.authorizationStatusToReturn = .restricted
        
        XCTAssertTrue(sut.isPermissionRequested)
    }
    
    func testIsPermissionRequestedWithNotDeterminedStatusReturnsFalse() {
        MockCNContactStore.authorizationStatusToReturn = .notDetermined
        
        XCTAssertFalse(sut.isPermissionRequested)
    }
    
    func testIsPermissionGrantedWithAuthorizedStatusReturnsTrue() {
        MockCNContactStore.authorizationStatusToReturn = .authorized
        
        XCTAssertTrue(sut.isPermissionGranted)
    }
    
    func testIsPermissionGrantedWithDeniedStatusReturnsFalse() {
        MockCNContactStore.authorizationStatusToReturn = .denied
        
        XCTAssertFalse(sut.isPermissionGranted)
    }
    
    func testIsPermissionGrantedWithRestrictedStatusReturnsFalse() {
        MockCNContactStore.authorizationStatusToReturn = .restricted
        
        XCTAssertFalse(sut.isPermissionGranted)
    }
    
    func testIsPermissionGrantedWithNotDeterminedStatusReturnsFalse() {
        MockCNContactStore.authorizationStatusToReturn = .notDetermined
        
        XCTAssertFalse(sut.isPermissionGranted)
    }
    
    func testRequestPermissionCallsDependencyMethod() {
        MockCNContactStore.authorizationStatusToReturn = nil
        
        sut.requestPermission(completionHandler: { _, _ in })
        
        XCTAssertTrue(contactStore.isRequestAccessCalled)
    }
}
