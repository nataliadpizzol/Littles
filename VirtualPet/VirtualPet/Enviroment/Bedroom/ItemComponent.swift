import SwiftUI

struct ItemComponent: View {
    @State var strokeColor: Color
    @State var backgroudColor: Color
    @State var isActive: Bool = false
    
    var item: Item
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .stroke(strokeColor, lineWidth: 6)
                .background(backgroudColor)
                .frame(width: 80, height: 80)
            Image(item.photo ?? "")
                .resizable()
                .frame(width: 60, height: 60)
        }
    }
}

//ItemComponent
