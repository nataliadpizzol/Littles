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
    
    //var to dismiss the onboarding 
    @Binding var showOnboarding: Bool
    
    var eggs: [String] = ["Pet1", "Pet2", "Pet3"]
    @State var eggSelected: [Bool] = [false, false, false]
    
    var body: some View {
        NavigationStack {
            HStack{
                Spacer()
                VStack {
                    Spacer()
                Text("Choose Your Egg")
                    .font(.fontStyle(.title))
                
                HStack {
                    ForEach(0..<eggs.count) { count in
                        Button(action: {
                            selectedEgg = true
                            eggSelected[0] = false
                            eggSelected[1] = false
                            eggSelected[2] = false
                            eggSelected[count] = true
                            
                            eggName = eggs[count]
                            selectedEgg = true
                            print(selectedEgg)
                            print(eggName)
                            print("selecionou 1 ovo")
                        }, label: {
                            Image(eggs[count])
                                .resizable()
                                .frame(width: eggSelected[count] ? 144 : 94, height: eggSelected[count] ? 166 : 116)
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
                                    users.first?.currentBuddy = pet
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
                    Spacer()
            }
                Spacer()
            }
            .background(
                Image("Onboarding2")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPresenting, destination: {NamingPet(eggName: eggName, showOnboarding: $showOnboarding)})
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
