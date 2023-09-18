//
//  MockCoordinator.swift
//  
//
//  Created by Erik Drobne on 25/05/2023.
//

import SwiftUI
import SwiftUICoordinator

class MockCoordinator: Routing {
    
    var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController
    let startRoute: MockRoute
    
    init(parent: Coordinator?, startRoute: MockRoute) {
        self.parent = parent
        self.navigationController = NavigationController()
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        
    }
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

