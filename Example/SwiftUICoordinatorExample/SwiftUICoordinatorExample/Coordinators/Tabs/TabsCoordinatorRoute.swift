//
//  TabsCoordinatorRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 14. 6. 24.
//

import UIKit
import SwiftUICoordinator

enum TabsCoordinatorRoute: TabBarNavigationRoute {
    case red
    case green
    case blue

    var tabBarItem: UITabBarItem {
        switch self {
        case .red:
            UITabBarItem(
                title: "Red",
                image: UIImage(systemName: "pencil.tip"),
                tag: 0
            )
        case .green:
            UITabBarItem(
                title: "Green",
                image: UIImage(systemName: "pencil"),
                tag: 1
            )
        case .blue:
            UITabBarItem(
                title: "Blue",
                image: UIImage(systemName: "pencil.and.scribble"),
                tag: 2
            )
        }
    }
}
