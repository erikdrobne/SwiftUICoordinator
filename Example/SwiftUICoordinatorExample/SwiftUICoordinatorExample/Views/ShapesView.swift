//
//  ShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI

struct ShapesView: View {

    @EnvironmentObject var coordinator: ShapesCoordinator

    var body: some View {
        List {
            Button {
                coordinator.didTap(route: .circle)
            } label: {
                Text("Circle")
            }

            Button {
                coordinator.didTap(route: .rectangle)
            } label: {
                Text("Rectangle")
            }

            Button {
                coordinator.didTap(route: .square)
            } label: {
                Text("Square")
            }
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesView()
    }
}
