//
//  FriendshipBarComponent.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 27/10/23.
//

import SwiftUI

struct XPBarComponent: View {
    @State private var progress: Float = 0.0
        
    var body: some View {
        VStack {
            ProgressView("Loading", value: progress, total: 1.0)
                .progressViewStyle(
                    LinearProgressViewStyle(tint: .brandPink))
                .frame(width: 200)
                .padding()
        }
        
        Button("Increase XP") {
            if progress < 1.0 {
                progress += 0.1
            }
        }
        .buttonPrimary()
        .padding()
    }
}

#Preview {
    XPBarComponent()
}
