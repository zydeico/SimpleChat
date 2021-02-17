//
//  Observable.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

final class Observable<T> {
    var observer: ((T?) -> Void)?
    var value: T? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.observer?(self?.value)
            }
        }
    }
    
    /// The observer closure will be called on the main thread.
    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
}
