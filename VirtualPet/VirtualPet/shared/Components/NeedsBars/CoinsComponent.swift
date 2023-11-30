import SwiftUI

struct CoinsComponent: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        ZStack {
            ProgressView(value: 0, total: 0)
                .progressBarPrimary(icon: "wallet")
        }
    }
}
