//
//  ShapesRoutes.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
import SwiftUICoordinator

enum ShapesRoute: NavigationRoute {
    case shapes
    case circle
    case rectangle
    case square

    var transition: NavigationTransitionStyle? {
        switch self {
        case .rectangle:
            return .present()
        case .square:
            return nil
        default:
            return .push()
        }
    }
}

