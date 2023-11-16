import SwiftUI

// Custom ProgressViewStyle
struct BarProgressStyle: ProgressViewStyle {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var icon: String
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 68)
                .fill(.brandWhite)
            
            RoundedRectangle(cornerRadius: 68)
                .fill(.brandColor5)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 200, height: 32)
                Image(icon)
                    .offset(x: 8)
                    .frame(height: 24)
            HStack{
                Spacer()
                switch icon {
                case "XP":
                    Text("Lvl. ")
                        .font(.fontStyle(.bold))
                        .foregroundStyle(.black)
                    Text(String(users.first!.getCurrentBuddy()!.level))
                        .font(.fontStyle(.bold))
                        .foregroundStyle(.black)
                case "heart":
                    Text("")
                case "wallet":
                    Text(String(users.first!.coins))
                        .font(.fontStyle(.bold))
                        .foregroundStyle(.black)
                default:
                    EmptyView()
                }
            }
        }
        .frame(width: 152, height: 32)
    }
}

