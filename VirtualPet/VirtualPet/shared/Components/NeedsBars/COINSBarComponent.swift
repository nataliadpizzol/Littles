//
//  COINSBarComponent.swift
//  VirtualPet
//
//  Created by Maria Luísa Lamb Souto on 14/11/23.
//

import SwiftUI

struct COINSBarComponent: View {
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
