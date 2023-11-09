//
//  ProfileView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 08/11/23.
//

import SwiftUI

struct ProfileView: View {
    @State var friendshipProgress: Float = 20.0
    var message: String
    var body: some View {
            
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 33)
            .foregroundColor(.brandWhite)
            .frame(width: 500, height: 602)

            VStack {
                VStack {
                    Image("Pet1-happy")
                        .padding(.bottom, 24)
                    Text(message)
                        //.font(.baloo2(.regular, size: .body))
                    HStack {
                        Image(systemName: "heart")
                        ProgressView(value: friendshipProgress, total: 100)
                    }
                    .padding(EdgeInsets(top: 13, leading: 100, bottom: 0, trailing: 100))
                    Divider()
                        .padding(EdgeInsets(top: 26, leading: 44, bottom: 26, trailing: 44))
                    Text("Next Age")
                        .font(.fontStyle(.subtitle))
                        .padding(.bottom, 32)

                    HStack {
                        Image("Pet1-happy")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing, 18)
                        Image(systemName: "greaterthan")
                            .padding(.trailing, 18)
                        Image("Pet1-happy")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.2)
                            .padding(.trailing, 18)
                        Image(systemName: "greaterthan")
                            .padding(.trailing, 18)
                        Image("Pet1-happy")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.5)

                    }
                    .padding(EdgeInsets(top: 0, leading: 44, bottom: 56, trailing: 44))
                    
                    Button("Age My Little", action: {})
                        .buttonPrimary()
                }
            }
        }
        .background(.brandHeader)
    }
}

#Preview {
    ProfileView(message: "Jorginho wants to run away.")
}
