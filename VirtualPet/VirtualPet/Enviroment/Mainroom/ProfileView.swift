//
//  ProfileView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 08/11/23.
//

import SwiftUI

struct ProfileView: View {
    var friendshipProgress: Int32 = 12
    @Binding var petName: String
    var message: String
    var level: String
    @State var showNameEditor: Bool = false
    @State var navigateToMainRoom: Bool = false
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("bgBlue")
                .padding(.bottom, 200)
            VStack {
                HStack(alignment: .center) { // page header
                    Button(action: {dismiss()},
                           label: {Image("closeIcon")}
                    )
                    .buttonBack()
                    Spacer()
                    Text("My Little")
                        .font(.fontStyle(.title2))
                        .tracking(-2)
                    Spacer()
                    Button(action: {showNameEditor = true}, // edit name button
                           label: {Image("penIcon")}
                    )
                    .buttonBack()
                }
                .padding(EdgeInsets(top: 100, leading: 80, bottom: 150, trailing: 80))
                ZStack {
                    Rectangle() // rectangle shape
                        .clipShape(
                            .rect(
                                topLeadingRadius: 123,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 123
                            )
                        )
                        .foregroundColor(.brandWhite)
                    VStack {
                        HStack(alignment: .center) {
                            Text(petName)
                                .font(.fontStyle(.title))
                            Text("lvl " + level)
                                .font(.fontStyle(.caption))
                                .foregroundStyle(.buttonsBackground)
                                .padding(.top, 13)
                        }
                        .padding(.top, 30)
                        HStack {
                            ProgressView(value: Float(friendshipProgress), total: 100)
                                .accentColor(.buttonsBackground)
                                .background(.brandColor5)
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.buttonsBackground)
                        }
                        .padding(EdgeInsets(top: -50, leading: 100, bottom: 0, trailing: 100))
                        Text(message)
                            .font(.fontStyle(.body))
                            .padding(.top, -20)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 50, leading: 40, bottom: 0, trailing: 40))
            }
            Image("Pet1-happy")
                .scaleEffect(0.75)
                .padding(.bottom, 460)
            if showNameEditor {
                NameEditorComponent(currentPetName: "Lila", newPetName: "Baby", showTextEditor: $showNameEditor)
                    .padding(EdgeInsets(top: 200, leading: 60, bottom: 200, trailing: 60))
            }
        }
            .ignoresSafeArea()
    }
}

#Preview {
    ProfileView(friendshipProgress: 20, petName: .constant("Lila"), message: "Lila loves you.", level: "11")
}
