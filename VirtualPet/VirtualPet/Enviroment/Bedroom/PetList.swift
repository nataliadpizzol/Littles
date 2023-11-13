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
                PetListComponentBar(backgroudColor: .green, name: "Babies", quantity: "2/7")
                    .padding(.top, 20)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(pets) { pet in
//                        ForEach(pet.itemsArray) { pet in
//                            AccessoryComponent(pet: item)
//                        }
                    }
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    PetList()
}
