import SwiftUI

struct TabbarWardrobe: View {
    
    @EnvironmentObject var constants: Constants
    var barColor = Color(uiColor: UIColor.systemTeal)
    
    var body: some View {
        ZStack (alignment: .leading) {
            Rectangle()
                .fill(.brandPurple2)
                .frame(width: UIScreen.main.bounds.width, height: 60)
            HStack(spacing: 30){
                
                Button {
                    constants.currentWardrobe = .handBody
                } label: {
                    TabbarWardrobeComponent(backgroudColor: .brandPurple2, image: "HandBody", isActive: $constants.isHandBodyActive)
                        
                }
                
                Button {
                    constants.currentWardrobe = .glasses
                } label: {
                    TabbarWardrobeComponent(backgroudColor: .brandPurple2, image: "Glasses", isActive: $constants.isGlassesActive)
                }
                
                Button {
                    constants.currentWardrobe = .hat
                } label: {
                    TabbarWardrobeComponent(backgroudColor: .brandPurple2, image: "Hats", isActive: $constants.isHatActive)
                }
            }
            .padding(.leading, 25)
        }
        
    }
}

#Preview {
    TabbarView()
}
