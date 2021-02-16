//
//  PermissionRequestable.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

protocol PermissionRequestable {
    var isPermissionRequested: Bool { get }
    var isPermissionGranted: Bool { get }
    
    func requestPermission(completionHandler: @escaping (Bool, Error?) -> Void)
}
