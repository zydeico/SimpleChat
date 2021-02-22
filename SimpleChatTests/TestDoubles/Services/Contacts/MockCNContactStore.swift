//
//  MockCNContactStore.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/16.
//

import Contacts

class MockCNContactStore: CNContactStore {
    static var authorizationStatusToReturn: CNAuthorizationStatus!
    
    var isRequestAccessCalled = false
    
    static override func authorizationStatus(for entityType: CNEntityType) -> CNAuthorizationStatus {
        return authorizationStatusToReturn
    }
    
    override func requestAccess(for entityType: CNEntityType, completionHandler: @escaping (Bool, Error?) -> Void) {
        isRequestAccessCalled = true
    }
    
    override func enumerateContacts(with fetchRequest: CNContactFetchRequest, usingBlock block: @escaping (CNContact, UnsafeMutablePointer<ObjCBool>) -> Void) throws {
        guard MockCNContactStore.authorizationStatusToReturn == .authorized else {
            fatalError("Permission not granted.")
        }
        block(CNContact(), UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1))
    }
}
