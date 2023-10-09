//
//  RootCoordinator.swift
//
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI

@MainActor
open class RootCoordinator: Coordinator {
    
    /// RootCoordinator doesn't have a parent
    public let parent: Coordinator? = nil
    public var childCoordinators: [WeakCoordinator] = []
    
    let window: UIWindow
    let navigationController: NavigationController
    
    public init(window: UIWindow, navigationController: NavigationController) {
        self.window = window
        self.navigationController = navigationController
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    open func handle(_ action: CoordinatorAction) {}
}


