//
//  ChatViewModelTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/20.
//
//  swiftlint:disable weak_delegate

import XCTest
@testable import SimpleChat

final class ChatViewModelTests: XCTestCase {
    let contact = Contact(name: "Name", lastName: "LastName", imageData: nil)
    var autoResponder: MockAutoResponseProvider!
    var sut: ChatViewModel!
    var delegate: MockChatViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        autoResponder = MockAutoResponseProvider()
        delegate = MockChatViewModelDelegate()
        sut = ChatViewModel(contact: contact, autoResponder: autoResponder)
        sut.delegate = delegate
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        autoResponder = nil
        delegate = nil
    }
}
