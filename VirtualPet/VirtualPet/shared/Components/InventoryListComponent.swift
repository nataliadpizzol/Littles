import SwiftUI

struct InventoryListComponent: View {
    @State var strokeColor: Color
    @State var backgroudColor: Color
    var item: Item
    
    var body: some View {
        
        Button(action: {
            //salve
        }, label: {
            ZStack{
                Rectangle()
                    .stroke(strokeColor, lineWidth: 3)
                    .background(backgroudColor)
                    .frame(width: 80, height: 80)
                Image(item.photo ?? "")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
        })
    }
}

//#Preview {
//    InventoryListComponent(strokeColor: .red, backgroudColor: .green, item.photo: "WardrobeAccessory2")
//}
