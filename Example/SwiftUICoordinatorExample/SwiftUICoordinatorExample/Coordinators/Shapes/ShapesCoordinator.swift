//
//  ShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
import SwiftUICoordinator

protocol ShapesCoordinatorNavigation {
    func didTap(route: ShapesRoute)
}

class ShapesCoordinator: NSObject, Coordinator, Navigator {

    // MARK: - Internal properties

    weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let startRoute: ShapesRoute?

    // MARK: - Initialization

    init(navigationController: UINavigationController = .init(), startRoute: ShapesRoute? = nil) {
        self.navigationController = navigationController
        self.startRoute = startRoute
        super.init()
    }

    func presentRoot() {
        popToRoot()
        childCoordinators.removeAll()
    }
}

// MARK: - ShapesCoordinatorNavigation

extension ShapesCoordinator: ShapesCoordinatorNavigation {
    func didTap(route: ShapesRoute) {
        switch route {
        case .square(let squaresRoute):
            guard let squaresRoute else {
                startSquaresCoordinator()
                return
            }

            let coordinator = SquaresCoordinator(parent: self, navigationController: navigationController)
            add(child: coordinator)
            coordinator.append(routes: [.squares, squaresRoute])
        default:
            show(route: route)
        }
    }

    // MARK: - Private methods

    private func startSquaresCoordinator() {
        let coordinator = SquaresCoordinator(parent: self, navigationController: navigationController, startRoute: .squares)
        add(child: coordinator)
        coordinator.start()
    }
}

// MARK: - RouterViewFactory

extension ShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: ShapesRoute) -> some View {
        switch route {
        case .shapes:
            ShapesView()
        case .circle:
            CircleView()
        case .rectangle:
            RectangleView()
        case .square:
            EmptyView()
        }
    }
}
