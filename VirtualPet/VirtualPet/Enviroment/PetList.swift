import SwiftUI

struct PetList: View {
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 40)
                    Text("Littles")
                        .frame(alignment: .center)
                        .font(.cherryBombOne(.regular, size: .title))
                        .padding(.horizontal, 37)
                    Circle()
                        .fill(Color.brandIcons)
                        .frame(width: 40)
                }
                .padding(.top, 40)
            }
            .frame(width: 600, height: 184)
            .background(Rectangle().fill(Color.white))
            
            Spacer()
            ScrollView{
                PetListComponentBar(backgroudColor: .green, name: "Babies", quantity: "2/7")
                    .padding(.top, 20)
                
                HStack{
#warning("Ajustar com foreach a logica dos pets")
                    PetListComponent(strokeColor: .white, backgroudColor: Color.background)
                    PetListComponent(strokeColor: .white, backgroudColor: Color.background)
                    PetListComponent(strokeColor: .white, backgroudColor: Color.background)
                    PetListComponent(strokeColor: .white, backgroudColor: Color.background)
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    PetList()
}
