//
//  UIViewController+StoryboardInstanceable.swift
//  SimpleChat
//
//  Created by Erik Lopez on 2021/02/09.
//

import UIKit

extension StoryboardInstanceable where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
            fatalError("The view controller could not be instantiated.")
        }
        return vc
    }
}
