//
//  MockRoute.swift
//  
//
//  Created by Erik Drobne on 25/05/2023.
//

import Foundation
import SwiftUICoordinator

enum MockRoute: NavigationRoute {
    case circle
    case rectangle
    case square
    
    var title: String? {
        switch self {
        case .circle:
            return "Circle"
        case .rectangle:
            return "Rectangle"
        case .square:
            return "Square"
        }
    }

    var action: TransitionAction? {
        switch self {
        case .square:
            return nil
        default:
            return .push(animated: true)
        }
    }
}
