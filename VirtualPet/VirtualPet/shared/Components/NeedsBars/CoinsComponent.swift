//
//  CoinsComponent.swift
//  VirtualPet
//
//  Created by Maria Luísa Lamb Souto on 14/11/23.
//

import SwiftUI

struct CoinsComponent: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        
        Text(String(users.first!.coins))
            .foregroundStyle(.black)
            .position(x: 20, y: 15)
    }
}
