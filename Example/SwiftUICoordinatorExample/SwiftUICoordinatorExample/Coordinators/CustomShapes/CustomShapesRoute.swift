//
//  CustomShapesRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import Foundation
import SwiftUICoordinator

enum CustomShapesRoute: NavigationRoute {
    case customShapes
    case triangle
    case star
    case tower

    var title: String? {
        switch self {
        case .customShapes:
            return "Custom shapes"
        case .triangle:
            return "Triangle"
        case .star:
            return "Star"
        case .tower:
            return "Tower"
        }
    }

    var action: TransitionAction? {
        return .push(animated: true)
    }
}
