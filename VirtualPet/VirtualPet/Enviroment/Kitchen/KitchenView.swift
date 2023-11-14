//
//  KitchenView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct KitchenView: View {
    
    @GestureState var plate = CGPoint(x: 200, y: 600)
    @State var foodLocation = CGPoint(x: 220, y: 400)
    @State var toEat = true
    @State var isEating = false
    var food: String = "carrot.fill"
    var mouth = CGPoint(x: 200, y: 250)
    var platePos = CGPoint(x: 220, y: 400)
    @EnvironmentObject var constants: Constants
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        VStack{
            ZStack {
                if constants.badroomLightIsOn{
                    Circle()
                        .foregroundStyle(.red)
                        .frame(width: 50, height: 50)
                        .position(mouth)
                    Image(self.isEating ? "Pet1-eat" : "Pet1-happy")
                        .resizable()
                        .frame(width: 270, height: 346)
                }
                else {
                    Circle()
                        .foregroundStyle(.red)
                        .frame(width: 50, height: 50)
                        .position(mouth)
                        .hidden()
                    Image(self.isEating ? "Pet1-eat" : "Pet1-happy")
                        .resizable()
                        .frame(width: 270, height: 346)
                        .hidden()
                }
                Image("tableKitchen")
                    .resizable()
                    .frame(width: 400, height: 600)
                
                VStack{
                    if toEat && constants.badroomLightIsOn{
                        Image(systemName: food)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .position(foodLocation)
                            .foregroundStyle(.orange)
                            .gesture(
                                DragGesture()
                                    .onChanged({ state in
                                        self.isEating = true
                                        foodLocation = state.location
                                        if (foodLocation.x >= mouth.x - 25 && foodLocation.x <= mouth.x + 25 && foodLocation.y >= mouth.y - 25 && foodLocation.y <= mouth.y + 25) {
                                            toEat = false
                                            isEating = false
                                            if let cb = users.first?.getCurrentBuddy(), cb.hunger < 100 {
                                                cb.hunger = 100
                                                constants.needTaskDone(cb, xp: 10, friendship: 5)
                                                do {
                                                    try managedObjectContext.save()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                                            }
                                            constants.objectWillChange.send()
                                        }
                                        
                                    })
                                    .onEnded({ state in
                                        self.isEating = false
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
            .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    KitchenView()
}
