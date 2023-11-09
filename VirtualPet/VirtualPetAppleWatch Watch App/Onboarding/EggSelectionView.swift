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
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var itens: FetchedResults<Item>
    
    @State var selectedEgg: Bool = false
    @State var isPresenting: Bool = false
    @State var eggName: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var eggs: [String] = ["Pet1", "Pet2", "Pet3"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose Your Egg")
                    .font(.fontStyle(.title))
                
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
                        // salvar o virtual pet no core data
                        for pet in virtualPets {
                            if let wpName = pet.name {
                                if wpName == eggName {
                                    pet.isKnow = true
                                    pet.favoriteFood = getFoods().randomElement()
                                    users.first?.currentBuddy = NSSet(object: pet)
                                    do {
                                        try managedObjectContext.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                        isPresenting = true
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
    
    private func getFoods() -> [Item]{
        var foods: [Item] = []
        for i in itens {
            if i.type == "Food" {
                foods.append(i)
            }
        }
        return foods
    }
}
