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
    
    func testIsSentByUserWhenWasSentByUserReturnsTrue() {
        sut.sendMessage(withText: "Some")
        
        XCTAssertTrue(sut.isSentByUser(at: IndexPath(item: 0, section: 0)))
    }
    
    func testIsSentByUserWhenWasNotSentByUserReturnsFalse() {
        autoResponder.shouldCreateResponse = true
        sut.sendMessage(withText: "Some")
        
        XCTAssertFalse(sut.isSentByUser(at: IndexPath(item: 1, section: 0)))
    }
    
    func testSendMessageAddItems() {
        let initialItemCount = sut.getNumberOfItems(in: 0)
        
        sut.sendMessage(withText: "Some")
        sut.sendMessage(withText: "Other")
        
        let newItemCount = sut.getNumberOfItems(in: 0)
        
        XCTAssertGreaterThan(newItemCount, initialItemCount)
    }
    
    func testSendMessageCallsAutoResponderCreateResponseMethod() {
        autoResponder.shouldCreateResponse = true
        sut.sendMessage(withText: "Some")
        
        XCTAssertTrue(autoResponder.isCreateResponseCalled)
    }
    
    func testSendMessageTriggersObservable() {
        var messageCount: Int?
        let expectation = self.expectation(description: "isMessageCountUpdated triggered")
        
        sut.isMessageCountUpdated.bind { count in
            messageCount = count
            expectation.fulfill()
        }
        
        sut.sendMessage(withText: "Some")
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertNotNil(messageCount)
    }
    
    func testGetCellViewModelReturnsChatCellViewModel() {
        let text = "Some"
        sut.sendMessage(withText: text)
        let model = sut.getCellViewModel(at: IndexPath(item: 0, section: 0))
        
        XCTAssertEqual(model, ChatCellViewModel(text: text))
    }
    
    func testIsMessageValidWhenInputIsNotEmptyReturnsTrue() {
        XCTAssertTrue(sut.isMessageValid(withText: "Some"))
    }
    
    func testIsMessageValidWhenInputIsEmptyReturnsFalse() {
        XCTAssertFalse(sut.isMessageValid(withText: ""))
    }
    
    func testTapBackCallsDidTapBackDelegateMethod() {
        sut.tapBack()
        
        XCTAssertTrue(delegate.isDidTapCalled)
    }
}
