//
//  ShapesRoutes.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import Foundation
import SwiftUICoordinator

enum ShapesRoute: NavigationRoute {
    case shapes
    case simpleShapes
    case customShapes
    case featuredShape(NavigationRoute)

    var title: String? {
        switch self {
        case .shapes:
            return "SwiftUI Shapes"
        default:
            return nil
        }
    }

    var transition: NavigationTransitionStyle? {
        switch self {
        case .simpleShapes:
            return nil
        default:
            return .push()
        }
    }
}

