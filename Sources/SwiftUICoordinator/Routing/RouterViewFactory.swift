//
//  RouterViewFactory.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation
import SwiftUI

@MainActor
public protocol RouterViewFactory {
    associatedtype V: View
    associatedtype Route: NavigationRoute

    @ViewBuilder
    func view(for route: Route) -> V
}
