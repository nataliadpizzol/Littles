import SwiftUI

struct XPBarComponent: View {
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        ZStack {
            ProgressView(value: Float(Int(users.first!.getCurrentBuddy()!.currentXP)), total: Float(Int(users.first!.getCurrentBuddy()!.xpToEvolve)))
                .progressBarPrimary(icon: "XP")
        }
    }
}
