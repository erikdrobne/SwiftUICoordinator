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
    var childCoordinators = [WeakCoordinator]()
    let navigationController: NavigationController
    let startRoute: ShapesRoute
    let factory: CoordinatorFactory

    // MARK: - Initialization

    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: ShapesRoute = .shapes,
        factory: CoordinatorFactory
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
        self.factory = factory
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
            EmptyView()
        }
    }
}
