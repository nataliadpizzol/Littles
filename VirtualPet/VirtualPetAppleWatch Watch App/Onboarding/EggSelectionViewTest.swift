//
//  EggSelectionViewTest.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 10/11/23.
//

import SwiftUI
import ACarousel


var roles = ["Luffy", "Zoro", "Sanji", "Nami", "Usopp", "Chopper", "Robin", "Franky", "Brook"]



struct EggSelectionViewTest: View {
    @State var spacing: CGFloat = 10
    @State var headspace: CGFloat = 10
    @State var sidesScaling: CGFloat = 0.8
    @State var isWrap: Bool = false
    @State var autoScroll: Bool = false
    @State var time: TimeInterval = 1
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            Text("\(currentIndex + 1)/\(roles.count)")
            Spacer().frame(height: 40)
            ACarousel(roles,
                      id: \.self,
                      index: $currentIndex,
                      spacing: spacing,
                      headspace: headspace,
                      sidesScaling: sidesScaling,
                      isWrap: isWrap,
                      autoScroll: autoScroll ? .active(time) : .inactive) { name in
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(30)
            }
            .frame(height: 300)
            Spacer()
            
            ControlPanel(spacing: $spacing,
                         headspace: $headspace,
                         sidesScaling: $sidesScaling,
                         isWrap: $isWrap,
                         autoScroll: $autoScroll,
                         duration: $time)
            Spacer()
        }
    }
}

