//
//  AccessoryComponent.swift
//  VirtualPet
//
//  Created by Maria Luísa Lamb Souto on 25/10/23.
//

import SwiftUI

struct AccessoryComponent: View {
    
    var item: Item
    
    var body: some View {
        VStack{
            Image(item.photo ?? "WardrobeAccessory1")
                .resizable()
                .frame(width: 50, height: 50)
            Text(item.name ?? "No item")
        }
    }
}

//    #Preview {
//        AccessoryComponent(item:)
//    }
