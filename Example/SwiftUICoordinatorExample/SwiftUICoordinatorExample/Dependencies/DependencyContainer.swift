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
    
    static let shared = DependencyContainer()
    
    private(set) var appCoordinator: AppCoordinator?
    let deepLinkHandler = DeepLinkHandler.shared
    
    private init() {}
    
    func set(_ coordinator: AppCoordinator) {
        guard appCoordinator == nil else {
            return
        }
        
        self.appCoordinator = coordinator
    }
}

extension DependencyContainer: CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        return AppCoordinator(window: window, navigationController: NavigationController())
    }
}
