//
//  DummyCoordinator.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/15.
//

@testable import SimpleChat

class DummyCoordinator: Coordinator {
    var router: Router = DummyRouter()
    
    func start() { }
}
