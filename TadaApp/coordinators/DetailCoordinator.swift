//
//  DetailCoordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class DetailCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [String : AnyObject]
    var preferredNavigationStyle: navigationStyle
    var removeCoordinatorWhenViewDismissed: ((Coordinator) -> ())
    
    var movieData:MovieModel!
    var viewModel:ViewModel!
    
    init(with navigationController: UINavigationController, using preferredNavigationStyle: navigationStyle, removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping ((Coordinator) -> ()), movieData: MovieModel, viewModel: ViewModel) {
        self.movieData = movieData
        self.viewModel = viewModel
        self.navigationController = navigationController
        self.childCoordinators = [:]
        self.preferredNavigationStyle = preferredNavigationStyle
        self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed
        
        super.init()
        
        navigationController.delegate = self
        start()
    }
    
    func start() {
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil, movieData: movieData, viewModel: viewModel, action: navigateToHomeController)
        navigate(to: viewController, with: .push, animated: false)
    }
    
    private func navigateToHomeController() {
    }
}

extension DetailCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(viewController) else {
                return
        }
        
        if viewController is DetailViewController {
            removeCoordinatorWhenViewDismissed(self)
        }
    }
}
