import SwiftUI

struct EggSelectionView: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPets: FetchedResults<VirtualPet>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @State var selectedEgg: Bool = false
    @State var isPresenting: Bool = false
    @State var eggName: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var eggs: [String] = ["Pet1", "Pet2", "Pet3"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose Your Egg")
                    .font(.cherryBombOne(.regular, size: .title))t
                
                HStack {
                    ForEach(eggs, id: \.self) { egg in
                        Button(action: {
                            selectedEgg = true
                        }, label: {
                            Image(egg)
                                .resizable()
                                .frame(width: 94, height: 116)
                                .onTapGesture {
                                    eggName = egg
                                    selectedEgg = true
                                    print(selectedEgg)
                                    print(eggName)
                                    print("selecionou 1 ovo")
                                }
                        })
                    }
                }
                .padding()
                
                if !selectedEgg == false {
                    Button(action: {
                        isPresenting = true
                        // salvar o virtual pet no core data
                        for pet in virtualPets {
                            if let wpName = pet.name {
                                if wpName == eggName {
                                    pet.isKnow = true
                                    users.first?.currentBuddy = NSSet(object: pet)
                                    do {
                                        try managedObjectContext.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                    }, label: {
                        Text("CHOOSE")
                    })
                    .buttonStyle(ButtonPrimary())
                    
                } else {
                    Button(action: {
                    }, label: {
                        Text("CHOOSE")
                    })
                    .buttonStyle(ButtonPrimary(isDisabled: true))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPresenting, destination: {NamingPet()})
        }
    }
}

//#Preview {
//    EggSelectionView()
//}
