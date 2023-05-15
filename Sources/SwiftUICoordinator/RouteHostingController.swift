//
//  RouteHostingController.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

import SwiftUI

public class RouteHostingController<Content: View>: UIHostingController<Content>, RouteProvider {
    public let route: NavigationRoute
    
    init(rootView: Content, route: NavigationRoute) {
        self.route = route
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
