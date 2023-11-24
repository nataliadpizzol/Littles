//
//  editNameComponent.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 24/11/23.
//

import SwiftUI

struct NameEditorComponent: View {
    @State var currentPetName: String
    @State var newPetName: String
    @Binding var showTextEditor: Bool

    var body: some View {
        VStack(spacing: 4) {
            Text("Change Name")
                .font(.fontStyle(.title2))
            TextField(currentPetName, text: $newPetName)
                .font(.fontStyle(.title))
                .foregroundColor(.gray)
                .background(Color.white)
                .cornerRadius(42)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack(spacing: 24) {
                Button("cancel", action: {showTextEditor.toggle()})
                    .buttonPrimary()
                    .padding(.top, 30)
                Button("save", action: {showTextEditor.toggle()})
                    .buttonPrimary()
                    .padding(.top, 30)
            }
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 24, trailing: 24))
        .foregroundStyle(.white)
        .background(.popUp)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .inset(by: -2.5)
                .stroke(.white, lineWidth: 5)
        )
    }
}
