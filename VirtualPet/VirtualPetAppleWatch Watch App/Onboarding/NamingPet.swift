//
//  NamingPet.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 25/10/23.
//

import SwiftUI


// Create a screen where the user can input a name for their pet. Ensure that the name is saved on core data.

struct NamingPet: View {
    @State var petName: String = ""
    
    var body: some View {
        TextField("Pick a name for your pet", text: $petName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

#Preview {
    NamingPet()
}
