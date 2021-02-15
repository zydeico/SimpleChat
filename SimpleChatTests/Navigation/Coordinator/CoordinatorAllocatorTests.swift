//
//  CoordinatorAllocatorTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/15.
//

import XCTest
@testable import SimpleChat

final class CoordinatorAllocatorTests: XCTestCase {
    let coordinator = DummyCoordinator()
    var sut: CoordinatorAllocator!

    override func setUp() {
        super.setUp()
        sut = CoordinatorAllocator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testAllocateShouldAppendCoordinator() {
        sut.allocate(coordinator)
        
        XCTAssertFalse(sut.childCoordinators.isEmpty)
    }
    
    func testDeallocateShouldRemoveCoordinator() {
        sut.allocate(coordinator)
        sut.deallocate(coordinator)
        
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
}
