//
//  MockChatViewModelDelegate.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/20.
//

import Foundation
@testable import SimpleChat

class MockChatViewModelDelegate: ChatViewModelDelegate {
    var isDidTapCalled = false
    
    func didTapBack() {
        isDidTapCalled = true
    }
}
