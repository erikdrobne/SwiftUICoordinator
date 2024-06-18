//
//  CoordinatorFactory.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
protocol CoordinatorFactory {
    func makeShapesCoordinator(parent: Coordinator) -> ShapesCoordinator
    func makeSimpleShapesCoordinator(parent: Coordinator) -> SimpleShapesCoordinator
    func makeCustomShapesCoordinator(parent: Coordinator) -> CustomShapesCoordinator
    func makeTabsCoordinator(parent: Coordinator) -> TabsCoordinator
}
