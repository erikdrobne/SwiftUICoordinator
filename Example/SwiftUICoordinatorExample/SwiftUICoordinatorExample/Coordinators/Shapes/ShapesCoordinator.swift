//
//  ShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
import SwiftUICoordinator

class ShapesCoordinator: Routing {

    // MARK: - Internal properties

    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: NavigationController
    let startRoute: ShapesRoute
    let factory: CoordinatorFactory

    // MARK: - Initialization

    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        factory: CoordinatorFactory,
        startRoute: ShapesRoute = .shapes
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.factory = factory
        self.startRoute = startRoute
    }

    func handle(_ action: CoordinatorAction) {
        switch action {
        case ShapesAction.simpleShapes:
            let coordinator = factory.makeSimpleShapesCoordinator(parent: self)
            try? coordinator.start()
        case ShapesAction.customShapes:
            let coordinator = factory.makeCustomShapesCoordinator(parent: self)
            try? coordinator.start()
        case let ShapesAction.featuredShape(route):
            switch route {
            case let shapeRoute as SimpleShapesRoute where shapeRoute != .simpleShapes:
                let coordinator = factory.makeSimpleShapesCoordinator(parent: self)
                coordinator.append(routes: [.simpleShapes, shapeRoute])
            case let shapeRoute as CustomShapesRoute where shapeRoute != .customShapes:
                let coordinator = factory.makeCustomShapesCoordinator(parent: self)
                coordinator.append(routes: [.customShapes, shapeRoute])
            default:
                return
            }
        case ShapesAction.tabs:
            let coordinator = factory.makeTabsCoordinator(parent: self)
            coordinator.start()
        case Action.done(_):
            popToRoot()
            childCoordinators.removeAll()
        default:
            parent?.handle(action)
        }
    }

    func handle(_ deepLink: DeepLink, with params: [String: String]) {
        switch deepLink.route {
        case ShapesRoute.customShapes:
            let coordinator = factory.makeCustomShapesCoordinator(parent: self)
            try? coordinator.start()
        default:
            break
        }
    }
}

// MARK: - RouterViewFactory

extension ShapesCoordinator: RouterViewFactory {

    @ViewBuilder
    public func view(for route: ShapesRoute) -> some View {
        switch route {
        case .shapes:
            ShapeListView<ShapesCoordinator>()
        case .simpleShapes:
            /// We are returning an empty view for the route presenting a child coordinator.
            EmptyView()
        case .customShapes:
            CustomShapesView<CustomShapesCoordinator>()
        case .featuredShape:
            /// We are returning an empty view for the route presenting a child coordinator.
            EmptyView()
        }
    }
}
