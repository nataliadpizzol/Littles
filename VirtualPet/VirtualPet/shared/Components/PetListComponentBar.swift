import SwiftUI

struct PetListComponentBar: View {
    @State var backgroudColor: Color
    @State var name = ""
    @State var quantity = ""
    
    var body: some View {
        
        Button(action: {
            //salve
        }, label: {
            ZStack{
                Rectangle()
                    .fill(backgroudColor)
                    .cornerRadius(20)
                    .frame(height: 30)
                    .padding(.horizontal, 120)
                HStack{
                    Text(name)
                        .font(.baloo2(.regular, size: .subtitle))
                    Spacer()
                    Text(quantity)
                        .font(.baloo2(.regular, size: .subtitle))
                }
                .padding(.horizontal, 140)
            }
        })
    }
}

#Preview {
    PetListComponentBar(backgroudColor: .green, name: "Babies", quantity: "2/7")
}
