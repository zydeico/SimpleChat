//
//  Coordinator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

protocol Coordinator: class {
    var router: Router { get }
    
    func start()
}