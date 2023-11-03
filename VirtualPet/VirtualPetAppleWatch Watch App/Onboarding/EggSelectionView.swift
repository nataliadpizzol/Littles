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
        VStack {
            Text("Choose Your Egg")
                .font(.cherryBombOne(.regular, size: .title))
            
            HStack {
                ForEach(eggs, id: \.self) { egg in
                    Image(egg)
                        .resizable()
                        .frame(width: 94, height: 116)
                        .onTapGesture {
                            print("selecionou ovo verde")
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
                    .buttonStyle(ButtonSecondary())
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
