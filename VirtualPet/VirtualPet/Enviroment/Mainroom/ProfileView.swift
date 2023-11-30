//
//  ProfileView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 08/11/23.
//

import SwiftUI

enum FriendshipMessages {
    case strangers
    case acquaintances
    case friends
    case bestfriends
    
    var message: String {
        switch self {
        case .strangers: return "Your little wants to run away."
        case .acquaintances: return "Your little is getting to know you."
        case .friends: return "Your little is your friend!"
        case .bestfriends: return "Your little loves you!"
        }
    }
}

struct ProfileView: View {
    var friendshipProgress: Int32 = 0
    var level: String
    @State var showNameEditor: Bool = false
    @State var navigateToMainRoom: Bool = false
    @Environment(\.dismiss) var dismiss
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPets: FetchedResults<VirtualPet>
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    @State var currentBuddy: VirtualPet?
    
    func getFriendshipMessage(friendshipLevel: Int32) -> String {
        switch friendshipLevel {
        case 0 ... 5: return FriendshipMessages.strangers.message
        case 5 ... 20: return FriendshipMessages.acquaintances.message
        case 20 ... 40: return FriendshipMessages.friends.message
        default: return FriendshipMessages.bestfriends.message
        }
    }
    
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
                    Image("myLittleText")
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
                            Text(currentBuddy?.name ?? "")
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
                                .onAppear {
                                    print("JORGE ", friendshipProgress)
                                }
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.buttonsBackground)
                        }
                        .padding(EdgeInsets(top: -50, leading: 100, bottom: 0, trailing: 100))
                        Text(getFriendshipMessage(friendshipLevel: currentBuddy?.friendship ?? 0))
                            .font(.fontStyle(.body))
                            .padding(.top, -20)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 70, leading: 40, bottom: 0, trailing: 40))
            }
            Image("Pet1-happy")
                .scaleEffect(0.75)
                .padding(.bottom, 460)
            if showNameEditor {
                NameEditorComponent(showTextEditor: $showNameEditor, currentBuddy: $currentBuddy)
                    .padding(EdgeInsets(top: 200, leading: 60, bottom: 200, trailing: 60))
            }
        }
            .ignoresSafeArea()
            .onAppear {
                currentBuddy = users.first?.getCurrentBuddy()
            }
    }
}
