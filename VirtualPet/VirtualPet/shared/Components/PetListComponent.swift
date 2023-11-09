import SwiftUI

struct PetListComponent: View {
    
    @State var strokeColor: Color
    @State var backgroudColor: Color

    var body: some View {
        
        RoundedRectangle(cornerRadius: 3)   .stroke(strokeColor, lineWidth: 3)
            .background(backgroudColor)
            .frame(width: 80, height: 80)
    }
}

#Preview {
    PetListComponent(strokeColor: .red, backgroudColor: .green)
}
