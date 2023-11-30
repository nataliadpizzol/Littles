import SwiftUI

struct FriendshipBarComponent: View {
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPet: FetchedResults<VirtualPet>
    @State var progress: Int = 0
    
    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: Float(progress), total: 100.0)
                    .progressBarPrimary(icon: "heart")
            }
        }
        .onAppear {
            progress = Int(virtualPet.first?.friendship ?? 0)
        }
    }
}
