import Foundation
import SwiftUI

final class NeedsBarViewModel: ObservableObject {
    
    func getProgressHeight(progress: Int) -> CGFloat {
        return CGFloat(progress) / 100 * 60
    }
    
    func getProgressColor(progress: Int) -> Color {
        if progress > 60 {
            return Color(.brandGreen)
        }
        if progress > 30 {
            return Color(.brandYellow)
        }
        return Color(.brandRed)
    }
    
}
