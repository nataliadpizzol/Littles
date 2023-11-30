import Foundation
import SwiftUI

extension ProgressView {
    func progressBarPrimary(icon: String) -> some View {
        self.progressViewStyle(ProgressBarPrimary(icon: icon))
    }
}
