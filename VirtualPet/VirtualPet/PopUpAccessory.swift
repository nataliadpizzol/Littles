import SwiftUI
import CoreData

struct PopUpAccessory: View {
    
    @Binding var isActive: Bool
    var item: Item
    var user: User
    var context: NSManagedObjectContext

//    var item: Item
    
    var body: some View {
        VStack {
            VStack{
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                Image(item.photo ?? "")
                    .resizable()
                    .frame(width: 50, height: 50)
                Button {
                    DataController().changeAccessory(newAccessory: item, user: user, context: context)
                    print("nova roupa: \(user.getCurrentBuddy()?.currentAccessoryImageName)")
                } label: {
                    Text("Change Accessory")
                }

            }
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(.gray)
    }
    
    func close() {
        withAnimation(.spring()) {
            isActive = false
            
        }
    }
}

//#Preview {
//    PopUpAccessory()
//}
