//
//  BathroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct BathroomView: View {
    
    @Binding var clean: Int
    @GestureState var tap = CGPoint(x: 200, y: 100)
    var tapPos = CGPoint(x: 200, y: 100)
    @State var tapLocation = CGPoint(x: 200, y: 100)
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
            .onChanged { state in
                tapLocation = state.location
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
                tapLocation = tapPos
                self.water = false
            }
            .updating($tap, body: { currentState, pastLocation, transaction in
                pastLocation = currentState.location
            })
    }
    
    var body: some View {
        VStack {
            Text("Bathroom")
            if clean == 100 {
                HStack{
                    Circle()
                        .foregroundStyle(self.water ? .red : .blue)
                        .frame(width: 200, height: 200)
                        .position(tapLocation)
                        .gesture(shower)
                }
            }
            Rectangle()
                .foregroundStyle(self.lather ? .red : ((self.finishShower == 0 && self.clean == 100) ? .green : .blue))
                .frame(width: 400, height: 400)
                .gesture(soap)
            
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BathroomView(clean: .constant(0))
}
