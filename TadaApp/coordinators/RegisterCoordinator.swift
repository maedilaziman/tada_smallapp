//
//  RegisterCoordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class RegisterCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [String : AnyObject]
    var preferredNavigationStyle: navigationStyle
    var removeCoordinatorWhenViewDismissed: ((Coordinator) -> ())
    
    init(with navigationController: UINavigationController, using preferredNavigationStyle: navigationStyle, removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping ((Coordinator) -> ())) {
        self.navigationController = navigationController
        self.childCoordinators = [:]
        self.preferredNavigationStyle = preferredNavigationStyle
        self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed
        
        super.init()
        
        navigationController.delegate = self
        start()
    }
    
    func start() {
        let viewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil, action: navigateToLoginController)
        navigate(to: viewController, with: .push, animated: false)
    }
    
    private func navigateToLoginController() {
        let coordinator = LoginCoordinator(with: navigationController, using: .push, removeCoordinatorWith: removeChild)
        addChild(coordinator: coordinator, with: "LoginViewController" as AnyObject)
    }
}

extension RegisterCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(viewController) else {
                return
        }
        
        if viewController is RegisterViewController {
            removeCoordinatorWhenViewDismissed(self)
        }
    }
}
