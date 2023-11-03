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
    
//    @State private var timerDecreaseEntertainmet: Timer?
//    @State private var timerDecreaseHunger: Timer?
//    @State private var timerDecreaseHygiene: Timer?
//    @State private var timerDecreaseSleep: Timer?
    
    var body: some View {
        NavigationStack {
            HStack {
                switch constants.currentEnviroment {
                case .mainroom:
                    MainroomView()
                case .kitchen:
                    KitchenView()
                case .bathroom:
                    BathroomView()
                case .bedroom:
                    BedroomView()
                case .garden:
                    GardenView()
                }
            }
        }
//        .onAppear {
//            if let cb = users.first?.getCurrentBuddy(){
//                timerDecreaseEntertainmet = Timer.scheduledTimer(withTimeInterval: 1, repeats: cb.entertainmet > 0) { _ in
//                    cb.entertainmet -= 1
//                    do {
//                        try managedObjectContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    constants.objectWillChange.send()
//                }
//                
//                timerDecreaseHunger = Timer.scheduledTimer(withTimeInterval: 1, repeats: cb.hunger > 0) { _ in
//                    cb.hunger -= 1
//                    do {
//                        try managedObjectContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    constants.objectWillChange.send()
//                }
//                
//                timerDecreaseHygiene = Timer.scheduledTimer(withTimeInterval: 1, repeats: cb.hygiene > 0) { _ in
//                    cb.hygiene -= 1
//                    do {
//                        try managedObjectContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    constants.objectWillChange.send()
//                }
//                
//                timerDecreaseSleep = Timer.scheduledTimer(withTimeInterval: 1, repeats: cb.sleep > 0) { _ in
//                    cb.sleep -= 1
//                    do {
//                        try managedObjectContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    constants.objectWillChange.send()
//                }
//            }
//        }
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
