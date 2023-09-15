//
//  DeepLinkHandler.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/09/2023.
//

import Foundation
import SwiftUICoordinator

class DeepLinkHandler: DeepLinkHandling {
    static let shared = DeepLinkHandler()
    
    let scheme = "coordinatorexample"
    let links: Set<DeepLink> = [
        DeepLink(action: "custom", route: ShapesRoute.customShapes)
    ]
    
    private init() {}
}
