//
//  MockDeepLinkHandler.swift
//
//
//  Created by Erik Drobne on 17/09/2023.
//

import Foundation
import SwiftUICoordinator

class MockDeepLinkHandler: DeepLinkHandling {
    static let shared = MockDeepLinkHandler()
    
    let scheme = "coordinatorexample"
    let links: Set<DeepLink> = [
        DeepLink(action: "circle", route: MockRoute.circle),
        DeepLink(
            action: "rectangle",
            route: MockRoute.square,
            params: ["color", "width", "height"]
        )
    ]
    
    private init() {}
}
