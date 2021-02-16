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
}
