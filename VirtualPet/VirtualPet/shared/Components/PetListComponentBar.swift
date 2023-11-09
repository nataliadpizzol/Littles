import SwiftUI

struct PetListComponentBar: View {
    @State var backgroudColor: Color
    @State var name = ""
    @State var quantity = ""

    #warning("AJUSTAR AQUI PARA TER UMA VARIAVEL PET, IGUAL AO INVENTORYLIST COMPONENT")
    
    var body: some View {
        
        Button(action: {
            //salve
        }, label: {
            ZStack{
                Rectangle()
                    .fill(backgroudColor)
                    .cornerRadius(20)
                    .frame(height: 30)
                HStack{
                    Text(name)
                        .font(.fontStyle(.subtitle))
                    Spacer()
                    Text(quantity)
                        .font(.fontStyle(.subtitle))
                }
                .padding(.horizontal, 20)
            }
        })
    }
}

#Preview {
    PetListComponentBar(backgroudColor: .green, name: "Babies", quantity: "2/7")
}
