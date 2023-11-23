//
//  ProfileView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 08/11/23.
//

import SwiftUI

struct ProfileView: View {
    var friendshipProgress: Int32
    @Binding var petName: String
    var message: String
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("bgBlue") // background image
                .padding(.bottom, 200)
            VStack {
                HStack(alignment: .center) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                           label: {Image("closeIcon")}
                    )
                    .buttonBack()
                    Spacer()
                    Text("My Little")
                        .font(.fontStyle(.title2))
                        .tracking(-2)
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                           label: {Image("penIcon")}
                    )
                    .buttonBack()
                }
                .padding(EdgeInsets(top: 112, leading: 80, bottom: 0, trailing: 80))

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
                        VStack {
                            Text(petName)
                                .font(.fontStyle(.title))
                            Text(message)
                                .font(.fontStyle(.body))
                                
                            HStack { //progress bar
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.buttonsBackground)
                                ProgressView(value: Float(friendshipProgress), total: 100)
                                    .foregroundStyle(.buttonsBackground)
                            }
                            .padding(EdgeInsets(top: 13, leading: 100, bottom: 300, trailing: 100))
                        }
                    }
                }
                .padding(.top, 100)
            }
            Image("Pet1-happy")
                .scaleEffect(0.9)
                .padding(.bottom, 430)
        }
            //.ignoresSafeArea()

    }
}

#Preview {
    ProfileView(friendshipProgress: 20, petName: .constant("Lila"), message: "Jorginho wants to run away.")
}
