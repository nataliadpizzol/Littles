import SwiftUI

struct NameEditorComponent: View {
    @State var newPetName: String = ""
    @Binding var showTextEditor: Bool
    @Binding var currentBuddy: VirtualPet?
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack(spacing: 4) {
            Image("changeNameText")
            TextField(currentBuddy?.name ?? "", text: $newPetName)
                .font(.fontStyle(.title))
                .foregroundColor(.gray)
                .background(Color.white)
                .frame(height: 50)
                .cornerRadius(42)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack(spacing: 24) {
                Button("cancel", action: {showTextEditor.toggle()})
                    .buttonPrimary()
                    .padding(.top, 30)
                Button(
                    action: {
                        currentBuddy?.name = newPetName
                        do {
                            try managedObjectContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        showTextEditor = false
                    },
                    label: {Text("save")}
                )
                .buttonPrimary()
                .padding(.top, 30)
            }
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 24, trailing: 24))
        .foregroundStyle(.white)
        .background(.popUp)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .inset(by: -2.5)
                .stroke(.white, lineWidth: 5)
        )
    }
}
