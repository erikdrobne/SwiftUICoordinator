//
//  CustomShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI
import SwiftUICoordinator

class CustomShapesCoordinator: Routing {

    // MARK: - Internal properties

    weak var parent: Coordinator?
    var childCoordinators = [WeakCoordinator]()
    var navigationController: NavigationController
    let startRoute: CustomShapesRoute

    // MARK: - Initialization

    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: CustomShapesRoute = .customShapes
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }

    func handle(_ action: CoordinatorAction) {
        switch action {
        case CustomShapesAction.triangle:
            try? show(route: .triangle)
        case CustomShapesAction.star:
            try? show(route: .star)
        case CustomShapesAction.tower:
            try? show(route: .tower)
        default:
            parent?.handle(action)
        }
    }
}

// MARK: - RouterViewFactory

extension CustomShapesCoordinator: RouterViewFactory {

    @ViewBuilder
    public func view(for route: CustomShapesRoute) -> some View {
        switch route {
        case .customShapes:
            CustomShapesView<CustomShapesCoordinator>()
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
