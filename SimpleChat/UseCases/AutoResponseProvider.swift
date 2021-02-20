//
//  AutoResponseProvider.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/20.
//

import Foundation

protocol AutoResponseProvider {
    func createResponse(withText text: String, completionHandler: @escaping (String) -> Void)
}
