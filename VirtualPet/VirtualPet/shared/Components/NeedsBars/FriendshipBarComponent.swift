//
//  FriendshipBarComponent.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 27/10/23.
//

import SwiftUI

struct FriendshipBarComponent: View {
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPet: FetchedResults<VirtualPet>
    @State var progress: Int = 0
        
    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: Float(progress), total: 100.0)
                    .progressViewStyle(BarProgressStyle(icon: "heart"))
            }
        }
        .onAppear {
                progress = Int(virtualPet.first?.friendship ?? 0)
       }
    }
}
