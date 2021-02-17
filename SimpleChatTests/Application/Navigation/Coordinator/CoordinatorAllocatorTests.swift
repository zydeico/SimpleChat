//
//  CoordinatorAllocatorTests.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/15.
//

import XCTest
@testable import SimpleChat

final class CoordinatorAllocatorTests: XCTestCase {
    private let coordinator = DummyCoordinator()
    private var sut: CoordinatorAllocator!

    override func setUp() {
        super.setUp()
        sut = CoordinatorAllocator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testAllocateAppendsCoordinator() {
        sut.allocate(coordinator)
        
        XCTAssertFalse(sut.childCoordinators.isEmpty)
    }
    
    func testDeallocateRemovesCoordinator() {
        sut.allocate(coordinator)
        sut.deallocate(coordinator)
        
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
}
