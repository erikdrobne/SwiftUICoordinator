//
//  TabsCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 11. 6. 24.
//

import Foundation

import SwiftUI
import SwiftUICoordinator

class TabsCoordinator: TabBarRouting {
    let navigationController: NavigationController
    let tabBarController = UITabBarController()
    let tabs: [TabsCoordinatorRoute]

    // MARK: - Internal properties

    weak var parent: Coordinator?
    var childCoordinators = [WeakCoordinator]()

    // MARK: - Initialization

    init(parent: Coordinator?, navigationController: NavigationController) {
        self.parent = parent
        self.navigationController = navigationController
        self.tabs = [.red, .green, .blue]
    }
    
    func handle(_ action: CoordinatorAction) {
        parent?.handle(action)
    }
}

// MARK: - RouterViewFactory

extension TabsCoordinator: RouterViewFactory {
    
    @ViewBuilder
    public func view(for route: TabsCoordinatorRoute) -> some View {
        switch route {
        case .red:
            VStack {
                Circle()
                    .foregroundStyle(.red)
            }
            .padding(16)
        case .green:
            VStack {
                Circle()
                    .foregroundStyle(.green)
            }
            .padding(16)
        case .blue:
            VStack {
                Circle()
                    .foregroundStyle(.blue)
            }
            .padding(16)
        }
    }
}
