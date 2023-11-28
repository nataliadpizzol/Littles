//
//  KitchenView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct KitchenView: View {
    
    @GestureState var plate = CGPoint(x: 200, y: 600)
    @State var foodLocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5)
    @State var toEat = true
    @State var isEating = false
    var food: String = "carrot.fill"
    var mouth = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 2 * UIScreen.main.bounds.height/3)
    var platePos = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5)
    @EnvironmentObject var constants: Constants
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    @State var navigateToFridge: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                ZStack {
                    if constants.badroomLightIsOn{
                        Circle()
                            .foregroundStyle(.red)
                            .frame(width: 50, height: 50)
                            .position(mouth)
                        ZStack {
                            
                            Image(self.isEating ? "Pet1-happy" : (users.first?.getCurrentBuddy()?.hunger ?? 100 < 50 ? "Pet1-sad" : "Pet1-happy"))
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                .offset(y: getProportionalValue(40, reader: reader))
                            
                            Image(users.first?.getCurrentBuddy()?.hygiene ?? 100 < 30 ? "Dirty3" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 60 ? "Dirty2" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 90 ? "Dirty1" : "")))
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                .offset(y: getProportionalValue(40, reader: reader))
                        }
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
                    VStack {
                        Spacer()
                        ZStack{
                            Image("tableKitchen")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: getProportionalValue(250, reader: reader))
                                .offset(x: getProportionalValue(-10, reader: reader),y:getProportionalValue(90, reader: reader))
                            Image("Plate")
                                .resizable()
                                .frame(width: getProportionalValue(200, reader: reader), height: getProportionalValue(90, reader: reader))
                                .offset(y:getProportionalValue(100, reader: reader))
                        }
                    }
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
                                            if (foodLocation.x >= mouth.x - 20 && foodLocation.x <= mouth.x + 20 && foodLocation.y >= mouth.y - 20 && foodLocation.y <= mouth.y + 20) {
                                                if constants.vibration{
                                                    HapticManager.instance.impact(style: .heavy)
                                                }
                                                toEat = false
                                                isEating = false
                                                if let cb = users.first?.getCurrentBuddy(), cb.hunger < 100 {
                                                    cb.hunger = 100
                                                    if let user = users.first.self {
                                                        constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 1)
                                                    }
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
                HStack {
                    Button(action: {navigateToFridge = true},
                           label: {Image("fridgeIcon")}
                    )
                    .buttonNavigation()
                    .frame(width: 56, height: 56, alignment: .center)
                    Spacer()
                }
                .padding()
                TabbarView()
                    .padding()
            }
        }
        .navigationDestination(isPresented: $navigateToFridge, destination: {FridgeView()})
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}
