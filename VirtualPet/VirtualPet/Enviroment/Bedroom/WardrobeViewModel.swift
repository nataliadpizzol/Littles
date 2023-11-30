import Foundation
import CoreData

final class WardrobeViewModel: ObservableObject {
    
    public func changeAccessory(newAccessory: Item, user: User, context: NSManagedObjectContext) {
        let currentBuddy = user.getCurrentBuddy()
        currentBuddy?.currentAccessoryImageName = newAccessory.photo
        currentBuddy?.accessoryPositionX = newAccessory.positionX
        currentBuddy?.accessoryPositionY = newAccessory.positionY
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
