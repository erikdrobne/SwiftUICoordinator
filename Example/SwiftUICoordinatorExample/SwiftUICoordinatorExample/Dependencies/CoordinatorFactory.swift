//
//  CoordinatorFactory.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI
import SwiftUICoordinator

protocol CoordinatorFactory {
    func makeShapesCoordinator(parent: Coordinator) -> ShapesCoordinator
}
