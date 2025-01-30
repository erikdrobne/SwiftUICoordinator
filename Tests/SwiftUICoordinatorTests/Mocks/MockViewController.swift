//
//  MockViewController.swift
//  SwiftUICoordinator
//
//  Created by Erik Drobne on 30. 1. 25.
//

import UIKit
import SwiftUICoordinator

class MockViewController: UIViewController, RouteProvider {
    var route: NavigationRoute

    init(route: NavigationRoute) {
        self.route = route
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
