import SwiftUI

struct TabbarWardrobeComponent: View {
    @State var backgroudColor: Color
    @State var image: String
    @Binding var isActive: Bool
    
    var body: some View {
        
        ZStack{
            Image(image)
                .resizable()
                .opacity(isActive ? 1.0 : 0.30)
                .frame(width: 40, height: 35)
        }
    }
}
