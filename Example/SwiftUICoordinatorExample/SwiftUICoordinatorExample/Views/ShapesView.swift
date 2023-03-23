//
//  ShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI

struct ShapesView: View {

    @EnvironmentObject var coordinator: ShapesCoordinator
    @StateObject var viewModel = ViewModel()

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
    @MainActor class ViewModel: ObservableObject {
        var coordinator: ShapesCoordinator?

        func didTapBuiltIn() {
            coordinator?.didTap(route: .simpleShapes)
        }

        func didTapCustom() {
            coordinator?.didTap(route: .customShapes)
        }

        func didTapFeatured() {
            coordinator?.didTap(route: .featuredShape)
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static let coordinator = ShapesCoordinator()

    static var previews: some View {
        ShapesView()
            .environmentObject(coordinator)
    }
}
