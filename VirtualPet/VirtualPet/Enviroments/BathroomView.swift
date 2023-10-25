//
//  BathroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct BathroomView: View {
    
    @Binding var clean: Int
    @State private var lather = false
    @State private var water = false
    @State private var finishShower: Int = 0
    
    var soap: some Gesture {
        DragGesture()
            .onChanged { _ in
                if clean < 100 {
                    self.lather = true
                    self.clean = self.clean + 1
                    self.finishShower = self.finishShower + 1
                    print(self.clean)
                }
                else {
                    self.lather = false
                }
            }
            .onEnded { _ in 
                self.lather = false
            }
    }
    
    var shower: some Gesture {
        DragGesture()
            .onChanged { _ in
                if finishShower > 0 {
                    self.water = true
                    self.finishShower = self.finishShower - 1
                    print(self.finishShower)
                }
                else {
                    self.water = false
                }
            }
            .onEnded { _ in
                self.water = false
            }
    }
    
    var body: some View {
        VStack {
            Text("Bathroom")
            if clean == 100 {
                HStack{
                    Circle()
                        .foregroundStyle(self.water ? .red : .blue)
                }
                .gesture(shower)
            }
            Rectangle()
                .foregroundStyle(self.lather ? .red : ((self.finishShower == 0 && self.clean == 100) ? .green : .blue))
                .gesture(soap)
            
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BathroomView(clean: .constant(0))
}
