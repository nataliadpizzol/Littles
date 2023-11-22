import SwiftUI

struct TabbarWardrobeComponent: View {
    @State var backgroudColor: Color
    @State var image: String
    @State var isActive: Bool = false
        
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(backgroudColor))
                .frame(width: 80, height: 80)
                
            Image(image)
                .resizable()
                .frame(width: 50, height: 45)
        }
    }
}
