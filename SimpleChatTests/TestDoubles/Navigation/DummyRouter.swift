//
//  DummyRouter.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/15.
//

@testable import SimpleChat

class DummyRouter: Router {
    var rootPresentable: Presentable = FakePresentable()
    
    func setRoot(_ presentables: [Presentable]) { }

    func present(_ presentable: Presentable) { }
    
    func dismiss() { }
    
    func push(_ presentable: Presentable) { }
    
    func pop() { }
}
