import SwiftUI

struct PetListComponent: View {
    @State var strokeColor: Color
    @State var backgroudColor: Color
    @State var isActive: Bool = false
    var pet: Pet
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .stroke(strokeColor, lineWidth: 3)
                .background(backgroudColor)
                .frame(width: 80, height: 80)
            Image(pet.photo ?? "")
                .resizable()
                .frame(width: 60, height: 60)
        }
    }
}


//#Preview {
//    PetList(strokeColor: .red, backgroudColor: .green)
//}
