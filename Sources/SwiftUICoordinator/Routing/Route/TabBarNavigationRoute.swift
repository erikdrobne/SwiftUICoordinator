//
//  TabBarNavigationRoute.swift
//
//
//  Created by Erik Drobne on 24. 6. 24.
//

import UIKit

@MainActor
public protocol TabBarNavigationRoute: NavigationRoute, Hashable {
    var tabBarItem: UITabBarItem { get }
}
