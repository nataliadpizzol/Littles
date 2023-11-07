import SwiftUI

// Custom ProgressViewStyle
struct BarProgressStyle: ProgressViewStyle {
    var barColor: Color = .brandWhite
    var progressColor: Color = .brandColor1
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 68)
                .fill(.gray.opacity(0.5))
            
            RoundedRectangle(cornerRadius: 68)
                .fill(.blue)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 200, height: 32)
            Circle()
                .fill(.yellow)
                .offset(x: 8)
                .frame(height: 24)
        }
        .frame(width: 152, height: 32)
    }
}

