//
//  TabsCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 11. 6. 24.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

final class TabsCoordinator: TabBarRouting {
    // MARK: - Public properties
    
    let navigationController: NavigationController
    let tabBarController = UITabBarController()
    let tabs: [TabsCoordinatorRoute]
    
    // MARK: - Internal properties
    
    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    
    // MARK: - Initialization
    
    init(parent: Coordinator?, navigationController: NavigationController) {
        self.parent = parent
        self.navigationController = navigationController
        self.tabs = [.home, .search, .profile]
        
        setupTabBar()
    }
    
    // MARK: - Private methods
    
    private func setupTabBar() {
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .systemBackground
    }
    
    // MARK: - Coordinator methods
    
    func handle(_ action: CoordinatorAction) {
        parent?.handle(action)
    }
}

// MARK: - RouterViewFactory

extension TabsCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: TabsCoordinatorRoute) -> some View {
        switch route {
        case .home:
            TabView("Home") {
                Circle()
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        case .search:
            TabView("Search") {
                Circle()
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        case .profile:
            TabView("Profile") {
                Circle()
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

// MARK: - Helper Views

private extension TabsCoordinator {
    struct TabView<Content: View>: View {
        let title: String
        let content: Content
        
        init(_ title: String, @ViewBuilder content: () -> Content) {
            self.title = title
            self.content = content()
        }
        
        var body: some View {
            content
                .padding(16)
                .navigationTitle(title)
        }
    }
}
