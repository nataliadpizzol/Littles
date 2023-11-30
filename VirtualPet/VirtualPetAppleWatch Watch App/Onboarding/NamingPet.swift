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
    var eggName: String
    
    //var to dismiss the onboarding
    @Binding var showOnboarding: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack (alignment: .center){
                    Spacer()
                    Image("NameYourLittle")
                        .resizable()
                        .frame(width: 314, height: 31)
                    Text("Don't worry, you can change it later")
                        .font(.fontStyle(.bold))
                    Spacer()
                    Image(eggName)
                        .padding(.bottom, 50)
                    
                    VStack(spacing: 4) {
                        
                        TextField("Pick a name for your pet", text: $petName)
                            .font(.fontStyle(.body))
                            .foregroundColor(.gray)
                            .background(Color.white)
                            .cornerRadius(42)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(width: 280)
                    .foregroundStyle(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 60)
                            .stroke(Color("ButtonsBackground"), lineWidth: 5)
                    )
                    
                    if petName.isEmpty == false {
                        //se tiver texto pegar o texto e salvar no nome do virtual pet
                        Button(action: {
                            showOnboarding = false
                        }, label: {
                            Text("choose")
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
                        .padding(.top, 70)
                        
                    } else {
                        Button(action: {
                        }, label: {
                            Text("choose")
                        })
                        .buttonStyle(ButtonPrimary(isDisabled: true))
                        .padding(.top, 70)
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
