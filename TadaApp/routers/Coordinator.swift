//
//  Coordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [String:AnyObject] { get set }
    
    func start()
    func addChild(coordinator: Coordinator, with key: AnyObject)
    func removeChild(coordinator: Coordinator)
}

extension Coordinator {
    
    func addChild(coordinator: Coordinator, with key: AnyObject) {
        childCoordinators[key as! String] = coordinator
    }
    
    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.value !== coordinator }
    }
    
    func navigate(to viewController: UIViewController, with presentationStyle: navigationStyle, animated: Bool = true) {
        switch presentationStyle {
        case .present:
            navigationController.present(viewController, animated: animated, completion: nil)
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
}

enum navigationStyle {
    case present
    case push
}

