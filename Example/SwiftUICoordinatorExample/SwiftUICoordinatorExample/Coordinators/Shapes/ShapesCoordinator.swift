//
//  ShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
import SwiftUICoordinator

class ShapesCoordinator: NSObject, Routing {

    // MARK: - Internal properties

    /// Root coordinator doesn't have a parent.
    let parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController
    let startRoute: ShapesRoute

    // MARK: - Initialization

    init(startRoute: ShapesRoute) {
        self.navigationController = NavigationController()
        self.startRoute = startRoute
        super.init()
        
        setup()
    }
    
    func navigate(to route: NavigationRoute) {
        switch route {
        case ShapesRoute.simpleShapes:
            let coordinator = makeSimpleShapesCoordinator()
            try? coordinator.start()
        case ShapesRoute.customShapes:
            let coordinator = makeCustomShapesCoordinator()
            try? coordinator.start()
        case ShapesRoute.featuredShape(let route):
            switch route {
            case let shapeRoute as SimpleShapesRoute:
                let coordinator = makeSimpleShapesCoordinator()
                coordinator.append(routes: [.simpleShapes, shapeRoute])
            case let shapeRoute as CustomShapesRoute:
                let coordinator = makeCustomShapesCoordinator()
                coordinator.append(routes: [.customShapes, shapeRoute])
            default:
                return
            }
        default:
            return
        }
    }
    
    // MARK: - Private methods
    
    private func setup() {
        navigationController.register(FadeTransition())
    }

    private func makeSimpleShapesCoordinator() -> SimpleShapesCoordinator {
        let coordinator = SimpleShapesCoordinator(parent: self, navigationController: navigationController)
        add(child: coordinator)
        return coordinator
    }

    private func makeCustomShapesCoordinator() -> CustomShapesCoordinator {
        let coordinator = CustomShapesCoordinator(parent: self, navigationController: navigationController)
        add(child: coordinator)
        return coordinator
    }
}

// MARK: - RouterViewFactory

extension ShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: ShapesRoute) -> some View {
        switch route {
        case .shapes:
            ShapesView<ShapesCoordinator>()
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
