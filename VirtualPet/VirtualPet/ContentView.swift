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
    
    var body: some View {
        NavigationStack {
            HStack {
                switch constants.currentEnviroment {
                case .mainroom:
                    MainroomView(enterteinment: .constant(30))
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
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
