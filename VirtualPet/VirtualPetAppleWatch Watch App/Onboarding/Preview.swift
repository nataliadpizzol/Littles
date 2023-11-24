import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("Onboarding1")
                .resizable()
                .ignoresSafeArea()
               // .frame(width: UI)
        }
    }
}

#Preview {
    Preview()
}
