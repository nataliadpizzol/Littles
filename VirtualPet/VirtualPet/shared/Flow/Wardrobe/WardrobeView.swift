//
//  WardrobeView.swift
//  VirtualPet
//
//  Created by Maria Luísa Lamb Souto on 25/10/23.
//

import SwiftUI

struct WardrobeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var user: User
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            VStack{
                Text("Wardrobe")
                    .padding(.top, 60)
                    .font(.cherryBombOne(.regular, size: 30))
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        AccessoryComponent(item: item)
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 300)
            
            Spacer()
            
            // printar lista do usuário com itens que ele ja tem
            // printar lista de todos os itens, filtrando os que o usuario ja tem
            // esses itens devem permanecer com uma cor mais escura
        }
        .onAppear{
            //Building the itens app
            if items.count == 0 {
                DataController().addItem(name: "Óculos", photo: "WardrobeAccessory1", price: 20, type: "Acessorie", itemDescription: "Óculos vermelho", context: managedObjContext)
                DataController().addItem(name: "Boina", photo: "WardrobeAccessory2", price: 30, type: "Acessorie", itemDescription: "Boina vermelho", context: managedObjContext)
                DataController().addItem(name: "Cachecol", photo: "WardrobeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol colorido", context: managedObjContext)
                DataController().addItem(name: "Gravata", photo: "WardrobeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: managedObjContext)
            }
            //Building the user
            DataController().addUser(firstLogin: Date(), lastLogin: Date(), streak: 10, gems: 10, coins: 10, items: self.items, context: managedObjContext)
            
        }
    }
}

//#Preview {
//    WardrobeView()
//}
