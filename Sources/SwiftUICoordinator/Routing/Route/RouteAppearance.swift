//
//  RouteAppearance.swift
//  
//
//  Created by Erik Drobne on 17/09/2023.
//

import SwiftUI

/// A struct that defines the appearance of a view (or route) in the app.
public struct RouteAppearance {
    /// The background color associated with the route.
    let background: UIColor

    public init(background: UIColor) {
        self.background = background
    }
}
