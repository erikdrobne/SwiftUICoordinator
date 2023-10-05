//
//  CoordinatorFactory.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI

protocol CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator
}
