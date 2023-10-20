//
//  RouterViewFactory.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import SwiftUI

@MainActor
public protocol RouterViewFactory {
    /// The type of SwiftUI view to be created for a given route.
    associatedtype V: View
    /// The type of navigation route for which views will be created.
    associatedtype Route: NavigationRoute
    
    /// Creates a SwiftUI view for the specified navigation route.
    ///
    /// - Parameter `route`: The navigation route for which the view should be created.
    /// - Returns: A SwiftUI view (`V`) associated with the provided route.
    @ViewBuilder
    func view(for route: Route) -> V
}
