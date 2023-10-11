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
    
    let navigationController = NavigationController()
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
            transitions: [FadeTransition()]
        )
    }
    
    func makeShapesCoordinator(parent: Coordinator) -> ShapesCoordinator {
        return ShapesCoordinator(
            parent: parent,
            navigationController: self.navigationController,
            factory: self
        )
    }
    
    func makeSimpleShapesCoordinator(parent: Coordinator) -> SimpleShapesCoordinator {
        return SimpleShapesCoordinator(
            parent: parent,
            navigationController: self.navigationController
        )
    }

    func makeCustomShapesCoordinator(parent: Coordinator) -> CustomShapesCoordinator {
        return CustomShapesCoordinator(
            parent: parent,
            navigationController: self.navigationController
        )
    }
}

extension DependencyContainer {
    static let mock = DependencyContainer()
}
