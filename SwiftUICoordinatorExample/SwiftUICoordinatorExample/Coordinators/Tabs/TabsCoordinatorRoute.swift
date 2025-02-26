//
//  TabsCoordinatorRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 14. 6. 24.
//

import UIKit
import SwiftUICoordinator

enum TabsCoordinatorRoute: TabBarNavigationRoute {
    
    case home
    case search
    case profile

    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            UITabBarItem(
                title: "Home",
                image: UIImage(systemName: "house"),
                tag: 0
            )
        case .search:
            UITabBarItem(
                title: "Search",
                image: UIImage(systemName: "magnifyingglass"),
                tag: 1
            )
        case .profile:
            UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person"),
                tag: 2
            )
        }
    }
}
