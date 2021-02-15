//
//  CoordinatorAllocator.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class CoordinatorAllocator: CoordinatorAllocatable {
    var childCoordinators: [Coordinator] = []
    
    func allocate(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func deallocate(_ coordinator: Coordinator) {
        guard let i = childCoordinators.firstIndex(where: { $0 === coordinator }) else {
            fatalError("The coordinator was not previously allocated.")
        }
        childCoordinators.remove(at: i)
    }
}
