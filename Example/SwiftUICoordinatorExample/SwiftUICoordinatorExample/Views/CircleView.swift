//
//  CircleView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI

struct CircleView: View {
    var body: some View {
        VStack {
            Text("Circle")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Circle()
                .foregroundColor(.blue)
            Spacer()
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
