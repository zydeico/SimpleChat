//
//  MockAutoResponseProvider.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/20.
//

import Foundation
@testable import SimpleChat

class MockAutoResponseProvider: AutoResponseProvider {
    var shouldCreateResponse = false
    var isCreateResponseCalled = false
    
    func createResponse(withText text: String, completionHandler: @escaping (String) -> Void) {
        isCreateResponseCalled = true
        if shouldCreateResponse {
            completionHandler(text)
        }
    }
}
