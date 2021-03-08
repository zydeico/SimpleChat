//
//  Presentable.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/10.
//

import Foundation

protocol Presentable: AnyObject {
    func toPresent() -> Self
}
