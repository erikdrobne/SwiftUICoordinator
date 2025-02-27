//
//  AppCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import Foundation
import UIKit
import SwiftUICoordinator

final class AppCoordinator: RootCoordinator {
    
    private let factory: CoordinatorFactory
    
    init(
        window: UIWindow,
        navigationController: NavigationController,
        factory: CoordinatorFactory
    ) {
        self.factory = factory
        super.init(window: window, navigationController: navigationController)
    }
    
    func start() {
        let authCoordinator = factory.makeAuthCoordinator(parent: self)
        self.add(child: authCoordinator)
        authCoordinator.start()
    }

    override func handle(_ action: CoordinatorAction) {
        switch action {
        case Action.done(let authCoordinator as AuthCoordinator):
            self.remove(coordinator: authCoordinator)
            showMainFlow()
        default:
            assertionFailure("Unhandled coordinator action: \(action)")
        }
    }
    
    private func showMainFlow() {
        let catalogCoordinator = factory.makeCatalogCoordinator(parent: self)
        self.add(child: catalogCoordinator)
        catalogCoordinator.set(routes: [catalogCoordinator.startRoute])
    }
}

extension AppCoordinator: CoordinatorDeepLinkHandling {
    func handle(_ deepLink: SwiftUICoordinator.DeepLink, with params: [String: String]) {}
}
