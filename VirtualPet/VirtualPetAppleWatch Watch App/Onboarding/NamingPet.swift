import SwiftUI

struct NamingPet: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPets: FetchedResults<VirtualPet>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @State var petName: String = ""
    @State var isPresenting: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Pick a name for your pet")
                    .font(.cherryBombOne(.regular, size: .title))
                TextField("Pick a name for your pet", text: $petName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                if petName.isEmpty == false {
                    //se tiver texto pegar o texto e salvar no nome do virtual pet
                    Button(action: {
                        isPresenting = true
                    }, label: {
                        Text("Continuar")
                            .onTapGesture {
                                isPresenting = true
                                if let cb = users.first?.getCurrentBuddy() {
                                    cb.name = petName
                                    do {
                                        try managedObjectContext.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                                print(users.first?.currentBuddy)
                            }
                    })
                    .buttonStyle(ButtonPrimary())
                    
                } else {
                    Button(action: {
                    }, label: {
                        Text("Continuar")
                    })
                    .buttonStyle(ButtonSecondary())
                }
            }
            .navigationBarBackButtonHidden(true)

            .navigationDestination(isPresented: $isPresenting, destination: {ContentView()})
        }
    }
}

#Preview {
    NamingPet()
}
