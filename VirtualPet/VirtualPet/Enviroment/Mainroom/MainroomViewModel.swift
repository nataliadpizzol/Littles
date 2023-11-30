import Foundation

final class MainroomViewModel: ObservableObject {
    func getCGfloat(string: String?) -> CGFloat {
        guard let uwString = string else {
            return 0
        }
        if let floatValue = Float(uwString) {
            let cgFloatValue = CGFloat(floatValue)
            return cgFloatValue
        }
        return 0
    }
}
