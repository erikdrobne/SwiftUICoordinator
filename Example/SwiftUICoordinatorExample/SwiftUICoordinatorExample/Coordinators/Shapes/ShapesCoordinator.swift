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

    // MARK: - Initialization

    init(parent: Coordinator?, navigationController: NavigationController, startRoute: ShapesRoute) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
        
        setup()
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case ShapesAction.simpleShapes:
            let coordinator = makeSimpleShapesCoordinator()
            try? coordinator.start()
        case ShapesAction.customShapes:
            let coordinator = makeCustomShapesCoordinator()
            try? coordinator.start()
        case let ShapesAction.featuredShape(route):
            switch route {
            case let shapeRoute as SimpleShapesRoute where shapeRoute != .simpleShapes:
                let coordinator = makeSimpleShapesCoordinator()
                coordinator.append(routes: [.simpleShapes, shapeRoute])
            case let shapeRoute as CustomShapesRoute where shapeRoute != .customShapes:
                let coordinator = makeCustomShapesCoordinator()
                coordinator.append(routes: [.customShapes, shapeRoute])
            default:
                return
            }
        default:
            break
        }
    }
    
    func handle(_ deepLink: DeepLink, with params: [String : String]) {
        switch deepLink.route {
        case ShapesRoute.customShapes:
            let coordinator = makeCustomShapesCoordinator()
            try? coordinator.start()
        default:
            break
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
