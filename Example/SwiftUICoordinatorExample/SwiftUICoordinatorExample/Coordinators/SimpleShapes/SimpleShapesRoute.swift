//
//  SimpleShapesRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI
import SwiftUICoordinator

enum SimpleShapesRoute: NavigationRoute {
    case simpleShapes
    case rect
    case roundedRect
    case capsule
    case ellipse
    case circle

    var title: String? {
        switch self {
        case .simpleShapes:
            return "Simple Shapes"
        case .rect:
            return "Rectangle"
        case .roundedRect:
            return "Rounded Rectangle"
        case .capsule:
            return "Capsule"
        case .ellipse:
            return "Ellipse"
        case .circle:
            return "Circle"
        }
    }

    var transition: NavigationTransitionStyle? {
        return .push()
    }
}
