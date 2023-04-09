//
//  ShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
import SwiftUICoordinator

struct ShapesView<Coordinator: CoordinatorNavigator>: View {

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
    @MainActor class ViewModel<Coordinator: CoordinatorNavigator>: ObservableObject {
        var coordinator: Coordinator?

        func didTapBuiltIn() {
            //coordinator?.didTap(route: .simpleShapes)
        }

        func didTapCustom() {
            //coordinator?.didTap(route: .customShapes)
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

            //coordinator?.didTap(route: .featuredShape(route))
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static let coordinator = ShapesCoordinator()

    static var previews: some View {
        ShapesView<ShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
