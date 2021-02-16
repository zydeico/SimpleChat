//
//  HomeViewModel.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import Foundation

final class HomeViewModel {
    let title = "Simple Chat"
    
    private var items: [ContactCellViewModel] = [
        ContactCellViewModel(name: "Name", lastName: "LastName", imageData: nil)
    ]
    
    func getNumberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ContactCellViewModel {
        return items[indexPath.item]
    }
}