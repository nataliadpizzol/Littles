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
    
    @State var viewProfile = false
    @State var petName = ""
    @State var friendshipValue: Int32 = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Spacer()
                    XPBarComponent()
                    #warning("Descomentar quando o designer estiver pronto")
//                    CoinsComponent()
                    Spacer()
                    Button {
                        viewProfile = true
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.brandIcons)
                    }
                    .padding()
                    .navigationDestination(isPresented: $viewProfile) {
                        ProfileView(friendshipProgress: $friendshipValue, petName: $petName, message: "")
                    }
                    
                }
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
            .background(
                Image(constants.currentEnviroment.getbackground())
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            )
        }
        .onAppear {
            if let cb = users.first?.getCurrentBuddy(){
                petName = cb.name ?? ""
                friendshipValue = cb.friendship
                constants.timerDecreaseEntertainment = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToEntertainmentSec), repeats: cb.entertainmet > 0) { _ in
                    cb.entertainmet -= 1
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    constants.objectWillChange.send()
                }
                
                constants.timerDecreaseHunger = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToHungerSec), repeats: cb.hunger > 0) { _ in
                    cb.hunger -= 1
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    constants.objectWillChange.send()
                }
                
                constants.timerDecreaseHygiene = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToHygieneSec), repeats: cb.hygiene > 0) { _ in
                    cb.hygiene -= 1
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    constants.objectWillChange.send()
                }
                
                constants.timerDecreaseSleep = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToSleepSec), repeats: cb.sleep > 0) { _ in
                    cb.sleep -= 1
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    constants.objectWillChange.send()
                }
            }
        }
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
