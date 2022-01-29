//
//  HomeCoordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class HomeCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [String : AnyObject]
    var preferredNavigationStyle: navigationStyle
    var removeCoordinatorWhenViewDismissed: ((Coordinator) -> ())
    var loginModel: LoginModel!
    
    init(with navigationController: UINavigationController, using preferredNavigationStyle: navigationStyle, removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping ((Coordinator) -> ()), loginModel: LoginModel) {
        self.loginModel = loginModel
        self.navigationController = navigationController
        self.childCoordinators = [:]
        self.preferredNavigationStyle = preferredNavigationStyle
        self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed
        
        super.init()
        
        navigationController.delegate = self
        start()
    }
    
    func start() {
        let viewController = HomeViewController(nibName: "HomeViewController", bundle: nil, action: navigateToDetailController, actionLogout: navigateToLogout, loginModel: loginModel)
        navigate(to: viewController, with: .push, animated: false)
    }
    
    private func navigateToDetailController(movieData: MovieModel, viewModel: ViewModel) {
        let coordinator = DetailCoordinator(with: navigationController, using: .push, removeCoordinatorWith: removeChild, movieData: movieData, viewModel: viewModel)
        addChild(coordinator: coordinator, with: "DetailViewController" as AnyObject)
    }
    
    private func navigateToLogout() {
        let coordinator = LoginCoordinator(with: navigationController, using: .push, removeCoordinatorWith: removeChild)
        addChild(coordinator: coordinator, with: "LoginViewController" as AnyObject)
    }
}

extension HomeCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(viewController) else {
                return
        }
        
        if viewController is HomeViewController {
            removeCoordinatorWhenViewDismissed(self)
        }
    }
}
