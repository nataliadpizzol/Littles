//
//  ContentView.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 23/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var constants: Constants
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack{
                    HStack {
                        switch constants.currentEnviroment {
                        case .mainroom:
                            MainroomView()
                        case .kitchen:
                            KitchenView()
                        case .bathroom:
                            BathroomView()
                        case .bedroom:
                            BedroomFirstView()
//                    case .garden:
//                        GardenView()
                            
                        }
                    }
                }
                .toolbar(content: {
                    HStack{
                        XPBarComponent()
                            .padding(.trailing, 65)
                        CoinsComponent()
                    }
                })
                Spacer()
            }
            .background(
                Image(constants.currentEnviroment.getbackground())
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            )
        }
        .onAppear {
            if let user = users.first {
                if let cb = user.getCurrentBuddy(){
                    constants.timerDecreaseEntertainment = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToEntertainmentSec), repeats: true) { _ in
                        if cb.entertainmet != 0 {
                            cb.entertainmet -= 1
                            print(cb.entertainmet)
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            constants.objectWillChange.send()
                        }
                    }
                    
                    constants.timerDecreaseHunger = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToHungerSec), repeats: true) { _ in
                        if cb.hunger != 0 {
                            cb.hunger -= 1
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            constants.objectWillChange.send()
                        }
                    }
                    
                    constants.timerDecreaseHygiene = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToHygieneSec), repeats: true) { _ in
                        if cb.hygiene != 0 {
                            cb.hygiene -= 1
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            constants.objectWillChange.send()
                        }
                    }
                    
                    constants.timerDecreaseSleep = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToSleepSec), repeats: true) { _ in
                        if cb.sleep != 0 {
                            cb.sleep -= 1
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            constants.objectWillChange.send()
                        }
                    }
                    
                    constants.timerDecreaseFriendship = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeDecreaseFriendship), repeats: true) { _ in
                        if (cb.sleep == 0 && cb.hygiene == 0 && cb.hunger == 0 && cb.entertainmet == 0) {
                            cb.friendship -= 1
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            constants.objectWillChange.send()
                        }
                    }
                }
                else {
                    print("Jorge n reconheci pet")
                }
            }
        }
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
