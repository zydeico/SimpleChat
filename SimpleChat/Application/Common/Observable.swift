//
//  Observable.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/16.
//

import Foundation

final class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.observer?(self?.value)
            }
        }
    }
    private var observer: ((T?) -> Void)?
    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
}
