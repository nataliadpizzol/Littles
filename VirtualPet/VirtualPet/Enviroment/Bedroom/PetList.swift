import SwiftUI

struct PetList: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var pets: FetchedResults<Pet>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 40)
                    Text("Littles")
                        .frame(alignment: .center)
                        .font(.fontStyle(.title))
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
                HStack{
                    PetListComponentBar(backgroudColor: .green, name: "Pets", quantity: "1/6")
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                }
                ZStack{
                    LazyVGrid(columns: columns) {
                        ForEach(users) { user in
                            ForEach(user.petsArray) { pet in
                                PetListComponent(strokeColor: .pink, backgroudColor: Color.background, pet: pet)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.background)
    }
}
//
//#Preview {
//    PetList()
//}
