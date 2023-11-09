import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Text("Preview aqui")
            Image("Pet1-happy")
                .resizable()
                .frame(width: 270, height: 346)
        }
    }
}

#Preview {
    Preview()
}
