//
//  ChatCellViewModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/17.
//

import Foundation

struct ChatCellViewModel {
    let text: String
}

extension ChatCellViewModel {
    init(_ chat: ChatModel) {
        self.text = chat.message
    }
}