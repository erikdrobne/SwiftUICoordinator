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

extension RouterViewFactory where Self: ObservableObject {
    func hostingController(for route: Route) -> UIHostingController<some View> {
        let view: some View = self.view(for: route)
            .ifLet(route.title) { view, value in
                view.navigationTitle(value)
            }
            .if(route.attachCoordinator) { view in
                view.environmentObject(self)
            }

        return RouteHostingController(
            rootView: view,
            route: route
        )
    }

    func views(for routes: [Route]) -> [UIHostingController<some View>] {
        return routes.map { self.hostingController(for: $0) }
    }
}
