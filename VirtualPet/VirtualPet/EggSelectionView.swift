//
//  EggSelectionView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 24/10/23.
//

import SwiftUI

struct EggSelectionView: View {
    var eggs: [String] = ["EggGreen", "EggYellow", "EggPurple"]

    var body: some View {
        VStack {
            Text("Choose Your Egg")
                .font(.cherryBombOne(.regular, size: 40))
            
            HStack {
                ForEach(eggs, id: \.self) { egg in
                    Image(egg)
                        .resizable()
                        .frame(width: 94, height: 116)
                        .onTapGesture {
                            print("selecionou ovo verde")
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    EggSelectionView()
}
