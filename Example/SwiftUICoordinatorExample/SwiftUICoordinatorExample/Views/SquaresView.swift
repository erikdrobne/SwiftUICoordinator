//
//  SquaresView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 09/03/2023.
//

import SwiftUI

struct SquaresView: View {

    @EnvironmentObject var coordinator: SquaresCoordinator
    @StateObject var viewModel = ViewModel()

    var body: some View {
        List {
            Section("Squares") {
                Button {
                    viewModel.didTapBlue()
                } label: {
                    Text("Blue")
                }
                
                Button {
                    viewModel.didTapGreen()
                } label: {
                    Text("Green")
                }
                
                Button {
                    viewModel.didTapRed()
                } label: {
                    Text("Red")
                }
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension SquaresView {
    @MainActor class ViewModel: ObservableObject {
        var coordinator: SquaresCoordinator?

        func didTapBlue() {
            coordinator?.didTap(route: .square(color: .blue))
        }

        func didTapGreen() {
            coordinator?.didTap(route: .square(color: .green))
        }

        func didTapRed() {
            coordinator?.didTap(route: .square(color: .red))
        }
    }
}

struct SquaresView_Previews: PreviewProvider {
    static let coordinator = SquaresCoordinator(parent: nil)

    static var previews: some View {
        SquaresView()
            .environmentObject(coordinator)
    }
}


