//
//  NavigationRoute.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation

public protocol NavigationRoute {
    var transition: NavigationTransitionStyle? { get }
}
