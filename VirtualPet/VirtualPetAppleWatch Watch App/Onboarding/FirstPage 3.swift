import SwiftUI

struct FirstPage: View {
    var body: some View {
        ZStack{
            Image("Onboarding1")
            Text("tap to start")
                .font(.fontStyle(.title2))
                .padding(.bottom, 400)
        }
    }
}

#Preview {
    FirstPage()
}
