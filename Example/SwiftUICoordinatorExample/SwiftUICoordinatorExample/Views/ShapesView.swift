//
//  ShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
import SwiftUICoordinator

struct ShapesView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View {
        List {
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Built-in")
            }
            Button {
                viewModel.didTapCustom()
            } label: {
                Text("Custom")
            }
            Button {
                viewModel.didTapFeatured()
            } label: {
                Text("Featured")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension ShapesView {
    @MainActor class ViewModel<Coordinator: Routing>: ObservableObject {
        var coordinator: Coordinator?

        func didTapBuiltIn() {
            coordinator?.navigate(to: ShapesRoute.simpleShapes)
        }

        func didTapCustom() {
            coordinator?.navigate(to: ShapesRoute.customShapes)
        }

        func didTapFeatured() {
            let routes: [NavigationRoute] = [
                SimpleShapesRoute.circle,
                CustomShapesRoute.tower,
                SimpleShapesRoute.capsule
            ]

            guard let route = routes.randomElement() else {
                return
            }

            coordinator?.navigate(to: ShapesRoute.featuredShape(route))
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static let coordinator = ShapesCoordinator(startRoute: ShapesRoute.shapes)

    static var previews: some View {
        ShapesView<ShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
