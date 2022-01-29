//
//  AppCoordinator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private var window: UIWindow
    internal var childCoordinators: [String : AnyObject]
    internal var navigationController: UINavigationController
    
    public var rootViewController: UIViewController {
        return navigationController
    }
    
    init(in window: UIWindow) {
        self.childCoordinators = [:]
        self.navigationController = UINavigationController()
        self.window = window
        self.window.backgroundColor = .white
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    public func start() {
        let rootViewCoordinator = RootCoordinator(with: navigationController)
        addChild(coordinator: rootViewCoordinator, with: "RootViewController" as AnyObject)
    }
}
