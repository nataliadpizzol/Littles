import SwiftUI

struct EggSelectionView: View {
    
    @State var selectedEgg: Bool
    @State var eggName: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var eggs: [String] = ["FirstEgg", "SecondEgg", "ThirdEgg"]
    
    var body: some View {
        VStack {
            Text("Choose Your Egg")
                .font(.cherryBombOne(.regular, size: 40))
            
            HStack {
                ForEach(eggs, id: \.self) { egg in
                    Button(action: {
                        selectedEgg = true
                        eggName = egg
                    }, label: {
                        Image(egg)
                            .resizable()
                            .frame(width: 94, height: 116)
                            .onTapGesture {
                                print("selecionou ovo verde")
                            }
                    })
                }
            }
            .padding()
            
            
            if selectedEgg==true {
                Button(action: {
                }, label: {
                    Text("CHOOSE")
                })
                .buttonStyle(ButtonPrimary())
            } else
            {
                Button(action: {
                }, label: {
                    Text("CHOOSE")
                })
                .buttonStyle(ButtonSecondary())
            }
            
            
            Button(action: {
            }, label: {
                Text("CHOOSE")
            })
            .buttonStyle(ButtonPrimary())
            //            .navigationDestination(isPresented: true, destination: NamingPet())
            
        }
        .onAppear {
            DataController().addVirtualPet(name: nil, birthday: nil, currentXP: 0, xpToEvolve: 10, friendship: 10, sleep: 30, hunger: 30, hygiene: 30, entertainmet: 30, steps: 30, index: 30, species: nil, isKnow: true, petDescription: nil, photo: nil, evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
            //colocar o virtual pet na lista de pet do user
            
            
        }
    }
}

//#Preview {
//    EggSelectionView()
//}
