//
//  DependencyContainer.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/09/2023.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
final class DependencyContainer {

    let factory = NavigationControllerFactory()
    let transitions = [FadeTransition()]
    lazy var delegate = factory.makeTransitionDelegate(transitions)
    lazy var navigationController = factory.makeNavigationController(delegate: self.delegate)

    let deepLinkHandler = DeepLinkHandler.shared

    private(set) var appCoordinator: AppCoordinator?

    func set(_ coordinator: AppCoordinator) {
        guard appCoordinator == nil else {
            return
        }

        self.appCoordinator = coordinator
    }
}

extension DependencyContainer: CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        return AppCoordinator(
            window: window,
            navigationController: self.navigationController,
            factory: self
        )
    }

    func makeTabsCoordinator(parent: Coordinator) -> TabsCoordinator {
        return TabsCoordinator(
            parent: parent,
            navigationController: self.navigationController
        )
    }
    
    func makeAuthCoordinator(parent: Coordinator) -> AuthCoordinator {
        return AuthCoordinator(
            parent: parent,
            navigationController: navigationController
        )
    }
    
    func makeCatalogCoordinator(parent: any Coordinator) -> CatalogCoordinator {
        return CatalogCoordinator(
            parent: parent,
            navigationController: navigationController
        )
    }
}

extension DependencyContainer {
    static let mock = DependencyContainer()
}
