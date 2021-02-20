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
    
    func testTitleReturnsContactName() {
        XCTAssertEqual(sut.title, contact.name)
    }
    
    func testGetNumberOfItemsReturnsItemsCount() {
        sut.sendMessage(withText: "Some")
        
        XCTAssertEqual(sut.getNumberOfItems(in: 0), 1)
    }
    
    func testGetSentByUserWhenIsSentByUserReturnsTrue() {
        sut.sendMessage(withText: "Some")
        
        XCTAssertTrue(sut.getSentByUser(at: IndexPath(item: 0, section: 0)))
    }
    
    func testGetSentByUserWhenIsNotSentByUserReturnsFalse() {
        autoResponder.shouldCreateResponse = true
        sut.sendMessage(withText: "Some")
        
        XCTAssertFalse(sut.getSentByUser(at: IndexPath(item: 1, section: 0)))
    }
}
