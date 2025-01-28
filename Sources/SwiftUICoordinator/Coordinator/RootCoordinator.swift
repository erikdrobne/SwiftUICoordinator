//
//  RootCoordinator.swift
//
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI

///  A coordinator responsible for managing the root navigation flow of the application.
///
/// The `RootCoordinator` class serves as the top-level coordinator in your application's coordinator hierarchy. 
/// It initializes the main window and navigation controller, manages child coordinators, and registers 
/// navigation transitions.
@MainActor
open class RootCoordinator: Coordinator {

    /// RootCoordinator doesn't have a parent
    public let parent: Coordinator? = nil
    public var childCoordinators = [WeakCoordinator]()

    public private(set) var window: UIWindow
    public private(set) var navigationController: NavigationController

    public init(window: UIWindow, navigationController: NavigationController) {
        self.window = window
        self.navigationController = navigationController

        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }

    open func handle(_ action: CoordinatorAction) {}
}
