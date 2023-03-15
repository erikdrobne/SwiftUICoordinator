//
//  SquaresCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 09/03/2023.
//

import SwiftUI
import SwiftUICoordinator

protocol SquaresCoordinatorNavigation {
    func didTap(route: SquaresRoute)
}

class SquaresCoordinator: Coordinator, Navigator {

    // MARK: - Internal properties

    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let startRoute: SquaresRoute?

    // MARK: - Initialization

    init(parent: Coordinator?, navigationController: UINavigationController = .init(), startRoute: SquaresRoute? = nil) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }

    func presentRoot() {
        parent?.presentRoot()
    }
}

extension SquaresCoordinator: SquaresCoordinatorNavigation {
    func didTap(route: SquaresRoute) {
        show(route: route)
    }
}

extension SquaresCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: SquaresRoute) -> some View {
        switch route {
        case .squares:
            SquaresView()
        case let .square(color):
            SquareView(color: color)
        case let .details(title, text):
            ShapeDetailsView(title: title, text: text)
        }
    }
}
