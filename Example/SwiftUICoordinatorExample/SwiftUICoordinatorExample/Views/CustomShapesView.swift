//
//  CustomShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI

struct CustomShapesView: View {

    @EnvironmentObject var coordinator: CustomShapesCoordinator
    @StateObject var viewModel = ViewModel()

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
    @MainActor class ViewModel: ObservableObject {
        var coordinator: CustomShapesCoordinator?

        func didTapTriangle() {
            coordinator?.didTap(route: .triangle)
        }

        func didTapStar() {
            coordinator?.didTap(route: .star)
        }

        func didTapTower() {
            coordinator?.didTap(route: .tower)
        }
    }
}

struct CustomShapesView_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesView()
    }
}
