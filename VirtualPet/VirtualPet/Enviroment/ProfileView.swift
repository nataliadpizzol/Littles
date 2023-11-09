//
//  ProfileView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 08/11/23.
//

import SwiftUI

struct ProfileView: View {
    @State var friendshipProgress: Float = 20.0
    var petName: String
    var message: String
    var body: some View {
            
        ZStack(alignment: .bottom) {
            Color.brandGrey
                .ignoresSafeArea()
            VStack {
                HStack() {
                    Text(petName)
                        .font(.fontStyle(.title))
                }
                Spacer(minLength: 280)
                ZStack {
                    RoundedRectangle(cornerRadius: 33)
                    .foregroundColor(.brandWhite)
                    VStack {
                        VStack {
                            Text(message)
                                .font(.fontStyle(.body))
                            HStack { //progress bar
                                Image(systemName: "heart")
                                ProgressView(value: friendshipProgress, total: 100)
                            }
                            .padding(EdgeInsets(top: 13, leading: 100, bottom: 0, trailing: 100))
                            Divider()
                                .padding(EdgeInsets(top: 26, leading: 44, bottom: 16, trailing: 44))
                            Text("Next Age")
                                .font(.fontStyle(.subtitle))
                                .padding(.bottom, 12)

                            HStack() { // pet evolution stages
                                Image("Pet1-happy")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(0.5)
                                    .padding(.trailing, 18)
                                Image(systemName: "greaterthan")
                                    .padding(.trailing, 18)
                                Image("Pet1-happy")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(0.8)
                                    .padding(.trailing, 18)
                                Image(systemName: "greaterthan")
                                    .padding(.trailing, 18)
                                Image("Pet1-happy")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(1)

                            }
                            .padding(EdgeInsets(top: 0, leading: 44, bottom: 56, trailing: 44))
                            
                            Button("Age My Little", action: {})
                                .buttonPrimary()
                        }
                    }
                }
                .ignoresSafeArea()
            }
            Image("Pet1-happy")
                .scaleEffect(0.9)
                .padding(.bottom, 430)
        }
    }
}

#Preview {
    ProfileView(petName: "Jorginho", message: "Jorginho wants to run away.")
}
