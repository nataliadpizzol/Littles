import SwiftUI

struct TabbarWardrobe: View {
    
    @EnvironmentObject var constants: Constants
    var barColor = Color(uiColor: UIColor.systemTeal)
    
    var body: some View {
        HStack(spacing: 30){
            Button {
                constants.currentWardrobe = .glasses
            } label: {
                TabbarWardrobeComponent(backgroudColor: .brandPurple2, image: "Glasses")
            }
            
            Button {
                constants.currentWardrobe = .handBody
            } label: {
                TabbarWardrobeComponent(backgroudColor: .brandPurple2, image: "HandBody")
            }
            
            Button {
                constants.currentWardrobe = .hats
            } label: {
                TabbarWardrobeComponent(backgroudColor: .brandPurple2, image: "Hats")
            }
        }
    }
}

#Preview {
    TabbarView()
}
