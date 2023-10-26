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
    @EnvironmentObject var enviromentTab: EnviromentTabView
    @State var apagarDepoisBanho = 0
    
    var body: some View {
        NavigationStack {
            HStack {
                switch enviromentTab.currentEnviroment {
                case .mainroom:
                    MainroomView()
                case .kitchen:
                    KitchenView()
                case .bathroom:
                    BathroomView(clean: $apagarDepoisBanho)
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
