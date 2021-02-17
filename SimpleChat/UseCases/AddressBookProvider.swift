//
//  AddressBookProvider.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

protocol AddressBookProvider {
    func getContacts() -> [Contact]
}
