//
//  NavigationRoute.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation

@MainActor
public protocol NavigationRoute {
    var title: String? { get }
    var transition: NavigationTransition? { get }
}
