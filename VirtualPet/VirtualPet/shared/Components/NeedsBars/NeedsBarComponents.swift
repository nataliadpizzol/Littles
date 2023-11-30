import SwiftUI
import CoreData

struct NeedsBarComponents: View {
    var image: String
    var enviroment: Enviroment
    @ObservedObject var vm = NeedsBarViewModel()
    @EnvironmentObject var constant: Constants
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPet: FetchedResults<VirtualPet>
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
            ZStack {
                
                Circle()
                    .foregroundStyle(.brandBlue)
                    .frame(width: 48, height: 48)
                
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(vm.getProgressColor(progress: users.first?.getProgress(enviroment: enviroment) ?? 0))
                    .mask{
                        VStack {
                            if let user = users.first, user.getProgress(enviroment: enviroment) < 100 {
                                Spacer()
                            }
                            
                            Rectangle()
                                .frame(width: 48)
                                .frame(height: vm.getProgressHeight(progress: users.first != nil ? users[0].getProgress(enviroment: enviroment) : 0))
                        }
                        .frame(height: 48)
                    }
                Image(image)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}
