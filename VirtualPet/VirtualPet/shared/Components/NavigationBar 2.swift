//
//  NavigationBar.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 09/11/23.
//

import SwiftUI

struct NavigationBar: View {
    var circleButton: Bool?
    var backButton: Bool?
    var pageTitle: String

    var body: some View {
        ZStack {
            Color.buttonsBackground
            HStack {
                Text(pageTitle)
                    .font(.fontStyle(.title))
                    .padding(EdgeInsets(top: 110, leading: 150, bottom: 22, trailing: 150))
            }
            HStack {
                Button("", action: {})
                    .buttonBack()
                Spacer()
                Button("", action: {})
                    .buttonCircle()
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        }
        .ignoresSafeArea()
        .frame(height: 50)
    }
}

#Preview {
    NavigationBar(pageTitle: "Littles")
}
