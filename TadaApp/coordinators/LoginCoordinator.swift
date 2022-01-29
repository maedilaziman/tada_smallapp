//
//  LoginCoordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class LoginCoordinator: NSObject, Coordinator {
    
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
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil, actionHome: navigateToHomeController, actionRegister: navigateToRegisterController)
        navigate(to: viewController, with: .push, animated: false)
    }
    
    private func navigateToHomeController(loginModel: LoginModel) {
        let coordinator = HomeCoordinator(with: navigationController, using: .push, removeCoordinatorWith: removeChild, loginModel: loginModel)
        addChild(coordinator: coordinator, with: "HomeViewController" as AnyObject)
    }
    
    private func navigateToRegisterController() {
        let coordinator = RegisterCoordinator(with: navigationController, using: .push, removeCoordinatorWith: removeChild)
        addChild(coordinator: coordinator, with: "RegisterViewController" as AnyObject)
    }
}

extension LoginCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(viewController) else {
                return
        }
        
        if viewController is LoginViewController {
            removeCoordinatorWhenViewDismissed(self)
        }
    }
}
