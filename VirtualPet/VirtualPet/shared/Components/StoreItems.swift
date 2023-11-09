//
//  StoreItems.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 07/11/23.
//

import SwiftUI

struct StoreItems: View {
    var label: String
    var price: Int
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 6) {
            Rectangle()
                .cornerRadius(18)
            Text(label)
                .font(.baloo2(.regular, size: .subtitle))
            ZStack {
                Image("PriceTag")
                Text(String(price))
                    .font(.baloo2(.regular, size: .subtitle))
                    .offset(x: 8)
            }
        }
    }
}

