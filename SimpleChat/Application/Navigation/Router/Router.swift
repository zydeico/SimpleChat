//
//  Router.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

protocol Router {
    var rootPresentable: Presentable { get }
    
    func setRoot(_ presentables: [Presentable])
    
    func present(_ presentable: Presentable)
    func dismiss()
    
    func push(_ presentable: Presentable)
    func pop()
}
