import SwiftUI

struct BuyComponent: View {
    
    @EnvironmentObject var constants: Constants
    @State var isActive: Bool = true
    @Environment(\.dismiss) var dismiss
    var item: Item
    
    func close() {
        withAnimation(.spring()) {
            isActive = false
        }
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Button {
                dismiss()
            } label: {
                ZStack{
                    Circle()
                        .strokeBorder(.white, lineWidth: 2)
                        .frame(width: 30, height: 30)
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 30, height: 22)
                        .foregroundColor(Color.white)
                }
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
                Text("60")
                Image("currency")
                    .resizable()
                    .frame(width: 10, height: 10)
            }
            
            Button("BUY", action: {})
                .buttonPrimary()
                .padding(.top, 30)
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

//
//#Preview {
//    BuyComponent()
//}
