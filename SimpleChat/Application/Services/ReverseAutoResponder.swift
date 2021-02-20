//
//  ReverseAutoResponder.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/20.
//

import Foundation

class ReverseAutoResponder: AutoResponseProvider {
    let responseDelayInSeconds: Int
    
    init(responseDelayInSeconds: Int = 5) {
        self.responseDelayInSeconds = responseDelayInSeconds
    }
    
    func createResponse(withText text: String, completionHandler: @escaping (String) -> Void) {
        let seconds = Double(arc4random_uniform(UInt32(responseDelayInSeconds)))
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + seconds, execute: {
            completionHandler(String(text.reversed()))
        })
    }
}
