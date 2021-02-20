//
//  ReverseAutoResponderTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/20.
//

import XCTest
@testable import SimpleChat

final class ReverseAutoResponderTests: XCTestCase {
    var sut: ReverseAutoResponder!
    
    override func setUp() {
        super.setUp()
        sut = ReverseAutoResponder(responseDelayInSeconds: 0)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCreateResponseCompletesWithReversedString() {
        let text = "Some"
        let expectedText = String(text.reversed())
        
        sut.createResponse(withText: text) { response in
            XCTAssertEqual(response, expectedText)
        }
    }
}
