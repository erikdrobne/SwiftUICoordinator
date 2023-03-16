//
//  RectangleView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI

struct RectangleView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.yellow)
            .ignoresSafeArea()
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
