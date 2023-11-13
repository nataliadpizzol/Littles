//
//  FriendshipBarComponent.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 27/10/23.
//

import SwiftUI

struct XPBarComponent: View {
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: Float(Int(users.first!.getCurrentBuddy()!.currentXP)), total: Float(Int(users.first!.getCurrentBuddy()!.xpToEvolve)))
                    .progressViewStyle(BarProgressStyle())
            }
        }
    }
}
