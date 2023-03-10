//
//  SquaresView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 09/03/2023.
//

import SwiftUI

struct SquaresView: View {

    @EnvironmentObject var coordinator: SquaresCoordinator

    var body: some View {
        List {
            Button {
                coordinator.didTap(route: .square(color: .blue))
            } label: {
                Text("Blue")
            }

            Button {
                coordinator.didTap(route: .square(color: .green))
            } label: {
                Text("Green")
            }

            Button {
                coordinator.didTap(route: .square(color: .red))
            } label: {
                Text("Red")
            }
        }
    }
}

struct SquaresView_Previews: PreviewProvider {
    static var previews: some View {
        SquaresView()
    }
}


