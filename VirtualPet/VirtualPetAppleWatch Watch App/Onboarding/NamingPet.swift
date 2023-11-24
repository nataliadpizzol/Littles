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
    
    //var to dismiss the onboarding 
    @Binding var showOnboarding: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack{
                    Spacer()
                    Text("Pick a name for your pet")
                        .font(.fontStyle(.title))
                    TextField("Pick a name for your pet", text: $petName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    if petName.isEmpty == false {
                        //se tiver texto pegar o texto e salvar no nome do virtual pet
                        Button(action: {
                            showOnboarding = false
                        }, label: {
                            Text("Continuar")
                                .onTapGesture {
                                    showOnboarding = false
                                    if let cb = users.first?.getCurrentBuddy() {
                                        cb.name = petName
                                        do {
                                            try managedObjectContext.save()
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
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

        }
    }
}


