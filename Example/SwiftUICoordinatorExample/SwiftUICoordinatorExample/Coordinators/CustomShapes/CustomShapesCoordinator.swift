//
//  CustomShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI

import SwiftUI
import SwiftUICoordinator

protocol CustomShapesCoordinatorNavigation {
    func didTap(route: CustomShapesRoute)
}

class CustomShapesCoordinator: NSObject, Coordinator, Navigator {

    // MARK: - Internal properties

    weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let startRoute: CustomShapesRoute?

    // MARK: - Initialization

    init(parent: Coordinator?, navigationController: UINavigationController = .init(), startRoute: CustomShapesRoute? = .customShapes) {
        self.parent = parent
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

extension CustomShapesCoordinator: CustomShapesCoordinatorNavigation {
    func didTap(route: CustomShapesRoute) {
        show(route: route)
    }

    // MARK: - Private methods


}

// MARK: - RouterViewFactory

extension CustomShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: CustomShapesRoute) -> some View {
        switch route {
        case .customShapes:
            CustomShapesView()
        case .triangle:
            Triangle()
                .fill(.yellow)
                .frame(width: 300, height: 300)
        case .star:
            Star()
                .fill(.yellow)
                .frame(width: 200, height: 200)
        case .tower:
            Tower()
        }
    }
}
