//
//  KitchenView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct KitchenView: View {
    
    @Binding var hungry: Int
    @GestureState var plate = CGPoint(x: 200, y: 600)
    @State var foodLocation = CGPoint(x: 200, y: 600)
    @State var toEat = true
    var food: String = "carrot.fill"
    var mouth = CGPoint(x: 200, y: 200)
    var platePos = CGPoint(x: 200, y: 600)
    
    var body: some View {
        VStack{
            Text("Kitchen")
            ZStack {
                Rectangle()
                    .foregroundStyle(.blue)
                Circle()
                    .foregroundStyle(.red)
                    .frame(width: 100, height: 100)
                    .position(mouth)
                VStack{
                    if toEat {
                        Image(systemName: food)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .position(foodLocation)
                            .foregroundStyle(.orange)
                            .gesture(
                                DragGesture()
                                    .onChanged({ state in
                                        foodLocation = state.location
                                        if (foodLocation.x >= mouth.x - 50 && foodLocation.x <= mouth.x + 50 && foodLocation.y >= mouth.y - 50 && foodLocation.y <= mouth.y + 50) {
                                            toEat = false
                                        }
                                        
                                    })
                                    .onEnded({ state in
                                        withAnimation {
                                            foodLocation = platePos
                                        }
                                    })
                                    .updating($plate, body: { currentState, pastLocation, transaction in
                                        pastLocation = currentState.location
                                    })
                            )
                    }
                }
            }
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    KitchenView(hungry: .constant(0))
}
