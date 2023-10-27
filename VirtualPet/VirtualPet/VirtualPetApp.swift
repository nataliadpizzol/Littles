//
//  VirtualPetApp.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 23/10/23.
//

import SwiftUI

@main
struct VirtualPetApp: App {
    let dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(EnviromentTabView())
                .environmentObject(Constants())
        }
    }
}
