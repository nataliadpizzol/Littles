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
            .padding(.bottom, 10)
            
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.white,lineWidth: 3)
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.brandYellow))
                        .frame(width: 100, height: 100)
                    
                    Image(item.photo ?? "")
                        .resizable()
                        .frame(width: 70, height: 65)
                }
                
                
                Text("\(item.price)")
                    .font(.fontStyle(.title))
                Image("currency")
                    .resizable()
                    .frame(width: 32, height: 40)
            }
            
            Button("BUY", action: {
                if users.first!.coins - Int64(item.price) >= 0 {
                    constants.checkToGetCoins(users.first!, -Int64(item.price))
                    users.first?.addToItems(item)
                    if item.type != "food" {
                        DataController().changeAccessory(newAccessory: item, user: user, context: managedObjectContext)
                    }
                }
                else {
                    showAlert = true
                }
            })
            .buttonPrimary()
            .padding(.top, 16)
        }
        .alert("Insufficient Funds. \nCare for your Little to earn coins! ", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 24))
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
