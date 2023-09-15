//
//  DependencyContainer.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/09/2023.
//

import Foundation

@MainActor
final class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    let deepLinkHandler = DeepLinkHandler.shared
    let rootCoordinator = ShapesCoordinator(startRoute: .shapes)
    
    private init() {}
}
