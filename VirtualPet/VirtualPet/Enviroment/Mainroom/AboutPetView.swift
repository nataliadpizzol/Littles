//
//  AbouPetView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 09/11/23.
//

import SwiftUI

struct AbouPetView: View {
    var pageTitle: String
    var bgColor: Color
    var species: String
    var description: String
    var body: some View {
        VStack {
            NavigationBar(pageTitle: "Littles")
        }
        VStack {
            Image("Pet1-happy")
                .scaleEffect(0.6)
                .padding(EdgeInsets(top: 43, leading: 0, bottom: 0, trailing: 0))
            Text(species)
                .font(.fontStyle(.subtitle))
                .padding(EdgeInsets(top: -60, leading: 24, bottom: 0, trailing: 24))
            Text(description)
                .font(.fontStyle(.body))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 24, trailing: 24))
            Divider()
                .padding(EdgeInsets(top: 10, leading: 44, bottom: 0, trailing: 44))
            Text("Aging")
                .font(.fontStyle(.subtitle))
            PetEvolutionStages()
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        }
    }
}
                   

#Preview {
    AbouPetView(pageTitle: "Littles", bgColor: .pink, species: "Bumble", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sodales mattis diam sed lacinia. In aliquet risus sed facilisis viverra. Phasellus vel rutrum purus, semper varius justo.")
}
