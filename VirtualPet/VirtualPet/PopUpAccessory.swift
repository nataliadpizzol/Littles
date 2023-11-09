import SwiftUI

struct PopUpAccessory: View {
    
    @Binding var isActive: Bool

//    var item: Item
    
    var body: some View {
        VStack (spacing: .zero) {
            VStack{
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                Text ("Deseja mudar esse acessório?")
                //            Image(item.photo ?? "")
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
