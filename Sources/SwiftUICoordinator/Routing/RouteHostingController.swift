//
//  RouteHostingController.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

import Foundation
import SwiftUI

public class RouteHostingController<Content: View>: UIHostingController<Content>, RouteProvider {
    
    // MARK: - Public properties
    
    public let route: NavigationRoute
    
    // MARK: - Initialization
    
    init(rootView: Content, route: NavigationRoute) {
        self.route = route
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
