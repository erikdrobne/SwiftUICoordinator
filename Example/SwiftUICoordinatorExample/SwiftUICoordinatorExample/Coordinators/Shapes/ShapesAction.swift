//
//  ShapesAction.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/07/2023.
//

import Foundation
import SwiftUICoordinator

enum ShapesAction: CoordinatorAction {
    case simpleShapes
    case customShapes
    case featuredShape(NavigationRoute)
}
