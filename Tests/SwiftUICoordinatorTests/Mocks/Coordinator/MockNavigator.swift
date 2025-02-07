//
//  MockNavigator.swift
//  SwiftUICoordinator
//
//  Created by Erik Drobne on 7. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

final class MockNavigator: Navigator {
    
    let navigationController: UINavigationController = MockNavigationController()
    let startRoute: MockRoute
    
    init(startRoute: MockRoute) {
        self.startRoute = startRoute
    }
    
    func hostingController(for route: MockRoute) -> UIViewController {
        return UIViewController()
    }
}

extension MockNavigator: RouterViewFactory {
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
