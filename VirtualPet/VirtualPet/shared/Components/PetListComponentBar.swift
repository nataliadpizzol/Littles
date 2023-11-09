import SwiftUI

struct PetListComponentBar: View {
    @State var backgroudColor: Color
    @State var name = ""
    @State var quantity = ""

    var body: some View {
        
        
        ZStack{
            Rectangle()
                .fill(backgroudColor)
                .cornerRadius(20)
                .frame(height: 30)
                .padding(.horizontal, 24)
            HStack{
                Text(name)
                    .font(.fontStyle(.subtitle))
                    .padding(.horizontal, 44)

                Spacer()
                Text(quantity)
                    .font(.fontStyle(.subtitle))
                    .padding(.horizontal, 44)
            }
        }
    }
}

#Preview {
    PetListComponentBar(backgroudColor: .green, name: "Babies", quantity: "2/7")
}
