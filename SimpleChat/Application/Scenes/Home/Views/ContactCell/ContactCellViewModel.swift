//
//  ContactCellViewModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

struct ContactCellViewModel {
    let name: String
    let lastName: String
    let imageData: Data?
}

extension ContactCellViewModel {
    init(_ contact: Contact) {
        self.name = contact.name
        self.lastName = contact.lastName
        self.imageData = contact.imageData
    }
}
