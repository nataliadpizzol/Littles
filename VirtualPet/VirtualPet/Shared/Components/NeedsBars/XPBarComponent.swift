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
    private var virtualPet: FetchedResults<VirtualPet>
    @State var progress: Int = 0
    @State var xpToEvolve: Int = 0
    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: Float(progress), total: Float(xpToEvolve))
                    .progressViewStyle(BarProgressStyle())
            }
        }
        .onAppear {
                progress = Int(virtualPet.first?.currentXP ?? 0)
                xpToEvolve = Int(virtualPet.first?.xpToEvolve ?? 100)
       }
    }
}
