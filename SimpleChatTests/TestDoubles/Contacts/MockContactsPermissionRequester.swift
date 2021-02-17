//
//  MockContactsPermissionRequester.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/17.
//

import Foundation
@testable import SimpleChat

class MockContactsPermissionRequester: PermissionRequestable {
    var isPermissionRequestedToReturn: Bool!
    var isPermissionGrantedToReturn: Bool!
    var requestPermissionValueToReturn: Bool!
    
    var isPermissionRequested: Bool {
        return isPermissionRequestedToReturn
    }
    
    var isPermissionGranted: Bool {
        return isPermissionGrantedToReturn
    }
    
    func requestPermission(completionHandler: @escaping (Bool, Error?) -> Void) {
        completionHandler(requestPermissionValueToReturn, nil)
    }
}
