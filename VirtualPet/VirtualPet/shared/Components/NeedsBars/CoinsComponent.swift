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
        ZStack {
            ProgressView(value: 0, total: 0)
                .progressViewStyle(BarProgressStyle(icon: "wallet"))
        }
    }
}
