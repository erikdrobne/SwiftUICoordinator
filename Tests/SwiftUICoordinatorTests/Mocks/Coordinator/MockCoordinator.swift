//
//  MockCoordinator.swift
//  
//
//  Created by Erik Drobne on 25/05/2023.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
class MockCoordinator: Routing {

    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    let startRoute: MockRoute

    init(startRoute: MockRoute, navigationController: NavigationController, parent: Coordinator? = nil) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }

    func handle(_ action: CoordinatorAction) {}
}

extension MockCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: MockRoute) -> some View {
        switch route {
        case .rectangle:
            RectangleView()
        case .circle:
            CircleView()
        default:
            EmptyView()
        }
    }
}
