//
//  CoordinatorHostingController.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

import SwiftUI

public protocol NavigationRouteHostingController {
    var route: NavigationRoute { get }
}

public class CoordinatorHostingController<Content: View>: UIHostingController<Content>, NavigationRouteHostingController {
    public let route: NavigationRoute
    
    init(rootView: Content, route: NavigationRoute) {
        self.route = route
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
