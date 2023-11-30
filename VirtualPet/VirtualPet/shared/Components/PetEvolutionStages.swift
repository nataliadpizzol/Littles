import SwiftUI

struct PetEvolutionStages: View {
    var body: some View {
        HStack() {
            Image("Pet1-happy")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.5)
                .padding(.trailing, 18)
            Image(systemName: "greaterthan")
                .padding(.trailing, 18)
            Image("Pet1-happy")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.8)
                .padding(.trailing, 18)
            Image(systemName: "greaterthan")
                .padding(.trailing, 18)
            Image("Pet1-happy")
                .resizable()
                .scaledToFit()
                .scaleEffect(1)
        }
    }
}

#Preview {
    PetEvolutionStages()
}
