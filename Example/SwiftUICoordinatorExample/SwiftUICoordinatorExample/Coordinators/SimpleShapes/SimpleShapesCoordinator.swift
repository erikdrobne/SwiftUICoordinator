//
//  SimpleShapesCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI
import SwiftUICoordinator

class SimpleShapesCoordinator: Routing {

    // MARK: - Internal properties

    weak var parent: Coordinator? = nil
    var childCoordinators = [WeakCoordinator]()
    var navigationController: NavigationController
    let startRoute: SimpleShapesRoute

    // MARK: - Initialization

    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: SimpleShapesRoute = .simpleShapes
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case SimpleShapesAction.rect:
            try? show(route: .rect)
        case SimpleShapesAction.roundedRect:
            try? show(route: .roundedRect)
        case SimpleShapesAction.capsule:
            try? show(route: .capsule)
        case SimpleShapesAction.ellipse:
            try? show(route: .ellipse)
        case SimpleShapesAction.circle:
            try? show(route: .circle)
        default:
            parent?.handle(action)
        }
    }
}

// MARK: - RouterViewFactory

extension SimpleShapesCoordinator: RouterViewFactory {
    
    @ViewBuilder
    public func view(for route: SimpleShapesRoute) -> some View {
        switch route {
        case .simpleShapes:
            SimpleShapesView<SimpleShapesCoordinator>()
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
            VStack {
                Spacer()
                Circle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                Spacer()
                Button {
                    self.handle(Action.done(self))
                } label: {
                    Text("Done")
                }
                .buttonStyle(.borderedProminent)
            }

        }
    }
}
