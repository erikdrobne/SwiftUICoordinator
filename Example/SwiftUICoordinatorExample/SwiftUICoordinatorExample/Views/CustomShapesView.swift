//
//  CustomShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI
import SwiftUICoordinator

struct CustomShapesView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View {
        List {
            Button {
                viewModel.didTapTriangle()
            } label: {
                Text("Triangle")
            }
            Button {
                viewModel.didTapStar()
            } label: {
                Text("Star")
            }
            Button {
                viewModel.didTapTower()
            } label: {
                Text("Tower")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension CustomShapesView {
    @MainActor class ViewModel<R: Routing>: ObservableObject {
        var coordinator: R?

        func didTapTriangle() {
            coordinator?.handle(CustomShapesAction.triangle)
        }

        func didTapStar() {
            coordinator?.handle(CustomShapesAction.star)
        }

        func didTapTower() {
            coordinator?.handle(CustomShapesAction.tower)
        }
    }
}

struct CustomShapesView_Previews: PreviewProvider {
    static let coordinator = CustomShapesCoordinator(parent: nil, navigationController: .init())
    
    static var previews: some View {
        CustomShapesView<CustomShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
