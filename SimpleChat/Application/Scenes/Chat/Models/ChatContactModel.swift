//
//  ChatContactModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/17.
//

import Foundation

struct ChatContactModel {
    let name: String
}

extension ChatContactModel {
    init(_ contact: Contact) {
        self.name = contact.name
    }
}
