//
//  FakePresentable.swift
//  SimpleChatTests
//
//  Created by Erik Lopez on 2021/02/15.
//

@testable import SimpleChat

class FakePresentable: Presentable {
    func toPresent() -> Self {
        return self
    }
}
