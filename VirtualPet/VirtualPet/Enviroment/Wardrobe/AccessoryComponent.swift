import SwiftUI

struct AccessoryComponent: View {
    
    var item: Item
    
    var body: some View {
        VStack{
            Image(item.photo ?? "WardrobeAccessory1")
                .resizable()
                .frame(width: 50, height: 50)
            Text(item.name ?? "No item")
        }
    }
    
}

//#Preview {
//    AccessoryComponent(item:)
//}
