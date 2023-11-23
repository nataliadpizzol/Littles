import SwiftUI

struct ItemComponent: View {
    @State var strokeColor: Color
    @State var backgroudColor: Color
    @State var isActive: Bool = false
    
    var item: Item
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(strokeColor,lineWidth: 3)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(backgroudColor))
                .frame(width: 80, height: 80)
                
            Image(item.photo ?? "")
                .resizable()
                .frame(width: 50, height: 45)
        }
    }
}
