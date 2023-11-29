import SwiftUI
import CoreData

struct BuyComponent: View {
    @EnvironmentObject var constants: Constants
    @Environment(\.dismiss) var dismiss
    var item: Item
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    @State var showAlert: Bool = false
    var user: User
    var managedObjectContext: NSManagedObjectContext
    
    
    var body: some View {
        VStack(spacing: 4) {
            HStack{
                Button( action: {constants.selectedItem = nil},
                        label: {Image(systemName: "xmark")}
                )
                .buttonBack()
                Spacer()
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.white,lineWidth: 3)
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.brandYellow))
                        .frame(width: 80, height: 80)
                    
                    Image(item.photo ?? "")
                        .resizable()
                        .frame(width: 50, height: 45)
                }
                Text("\(item.price)")
                Image("currency")
                    .resizable()
                    .frame(width: 10, height: 10)
            }
            
            Button("BUY", action: {
                if users.first!.coins - Int64(item.price) >= 0 {
                    constants.checkToGetCoins(users.first!, -Int64(item.price))
                    users.first?.addToItems(item)
                    DataController().changeAccessory(newAccessory: item, user: user, context: managedObjectContext)
                }
                else {
                    showAlert = true
                }
            })
                .buttonPrimary()
                .padding(.top, 30)
        }
        .alert("Insufficient Funds. \nCare for your Little to earn coins! ", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 24, trailing: 24))
        .foregroundStyle(.white)
        .background(.popUp)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .inset(by: -2.5)
                .stroke(.white, lineWidth: 5)
        )
    }
}
