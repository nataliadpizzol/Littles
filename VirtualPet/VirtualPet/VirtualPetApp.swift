//
//  VirtualPetApp.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 23/10/23.
//

import SwiftUI

@main
struct VirtualPetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EggSelectionView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
