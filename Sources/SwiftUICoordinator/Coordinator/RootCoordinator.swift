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
    public var childCoordinators = [WeakCoordinator]()
    private let transitions: [Transition]
    
    public private(set) var window: UIWindow
    public private(set) var navigationController: NavigationController
    
    public init(window: UIWindow, navigationController: NavigationController, transitions: [Transition]) {
        self.window = window
        self.navigationController = navigationController
        self.transitions = transitions
        
        navigationController.register(transitions)
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    open func handle(_ action: CoordinatorAction) {}
}


