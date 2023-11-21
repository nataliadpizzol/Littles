import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("Pet1-happy")
                .resizable()
                .frame(width: 221, height: 122)
        }
    }
}

#Preview {
    Preview()
}
