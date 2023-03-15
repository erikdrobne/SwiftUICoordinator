//
//  SquaresRoutes.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 09/03/2023.
//

import SwiftUI
import SwiftUICoordinator

enum SquaresRoute: NavigationRoute {
    case squares
    case square(color: Color)
    case details(title: String, text: String)

    var transition: NavigationTransitionStyle? {
        return .push()
    }
}
