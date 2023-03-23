//
//  SimpleShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI
import SwiftUICoordinator

protocol SimpleShapesCoordinatorNavigation {
    func didTap(route: SimpleShapesRoute)
}

class SimpleShapesCoordinator: NSObject, Coordinator, Navigator {

    // MARK: - Internal properties

    weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let startRoute: SimpleShapesRoute?

    // MARK: - Initialization

    init(parent: Coordinator?, navigationController: UINavigationController = .init(), startRoute: SimpleShapesRoute? = .simpleShapes) {
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

extension SimpleShapesCoordinator: SimpleShapesCoordinatorNavigation {
    func didTap(route: SimpleShapesRoute) {
        show(route: route)
    }

    // MARK: - Private methods

    
}

// MARK: - RouterViewFactory

extension SimpleShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: SimpleShapesRoute) -> some View {
        switch route {
        case .simpleShapes:
            SimpleShapesView()
        case .rect:
            Rectangle()
                .fill(.yellow)
                .frame(width: 200, height: 200)
        case .roundedRect:
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.red)
                .frame(width: 200, height: 200)
        case .capsule:
            Capsule()
                .fill(.pink)
                .frame(width: 200, height: 50)
        case .ellipse:
            Ellipse()
                .fill(.gray)
                .frame(width: 200, height: 100)
        case .circle:
            Circle()
                .fill(.blue)
                .frame(width: 200, height: 200)
        }
    }
}
