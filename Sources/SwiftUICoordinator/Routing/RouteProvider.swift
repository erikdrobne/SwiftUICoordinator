//
//  RouteProvider.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

@MainActor
public protocol RouteProvider {
    var route: NavigationRoute { get }
}
