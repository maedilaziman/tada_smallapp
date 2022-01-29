//
//  RootCoordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [String : AnyObject]
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [:]
        start()
    }
    
    func start() {
        let rootViewController = RootViewController(nibName: "RootViewController", bundle: nil, action: navigateToLoginController)
        navigate(to: rootViewController, with: .push, animated: false)
    }
    
    private func navigateToLoginController() {
        let coordinator = LoginCoordinator(with: navigationController, using: .push, removeCoordinatorWith: removeChild)
        addChild(coordinator: coordinator, with: "RootViewController" as AnyObject)
    }
}
