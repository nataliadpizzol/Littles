////
////  ContentView.swift
////  VirtualPet
////
////  Created by Natalia Dal Pizzol on 23/10/23.
////
//
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var enviromentTab: EnviromentTabView
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        NavigationStack {
            HStack {
                switch enviromentTab.currentEnviroment {
                case .mainroom:
                    MainroomView()
                case .kitchen:
                    KitchenView()
                case .bathroom:
                    BathroomView(clean: $constants.bath)
                case .bedroom:
                    BedroomView()
                case .garden:
                    GardenView()
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
