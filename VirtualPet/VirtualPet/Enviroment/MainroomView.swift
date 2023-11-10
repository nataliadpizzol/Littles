import SwiftUI

struct MainroomView: View {
    
    @ObservedObject var vm = MainroomViewModel()
    @State var isPetting: Bool = false
    @EnvironmentObject var constants: Constants
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var petting: some Gesture {
        DragGesture()
            .onChanged { _ in
                if let cb = users.first?.getCurrentBuddy(), cb.entertainmet < 100 {
                    isPetting = true
                    cb.entertainmet = cb.entertainmet + 1
                    if cb.entertainmet == 100 {
                        constants.needTaskDone(cb, xp: 10, friendship: 5)
                    }
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                else {
                    if let cb = users.first?.getCurrentBuddy(){
                        print(cb.entertainmet)
                    }
                    self.isPetting = true
                }
                constants.objectWillChange.send()
            }
            .onEnded { _ in
                self.isPetting = false
            }
    }
    
    var body: some View {
        VStack {
            Text("Mainroom")
            HStack{
                ZStack {
                    Image(users.first?.getCurrentBuddy()?.entertainmet ?? 0 > 70 || self.isPetting ? "Pet1-happy" : "Pet1-sad")
                        .resizable()
                        .frame(width: 270, height: 346)
                    if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                        
                        Image(accessoryImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                            .onAppear{
                                print("tem acessorio")
                            }
                    }
                }
                .gesture(petting)
                .padding(.top, 260)
            }
            .onAppear {
                //Using user default to validate first access to the app
                UserDefaults.standard.set(false, forKey: "firstTimeHere")

                // Change Later
                users.first?.getCurrentBuddy()?.currentAccessoryImageName = "WardrobeAccessory1"
                users.first?.getCurrentBuddy()?.accessoryPositionX = "140"
                users.first?.getCurrentBuddy()?.accessoryPositionY = "20"
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                print(users.first?.getCurrentBuddy()?.currentAccessoryImageName)
                print(users.first?.getCurrentBuddy()?.accessoryPositionX)
            }
            
            TabbarView()
        }
        .navigationBarBackButtonHidden()
        .background(
            Image("backgroudMainroom")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea())
    }
}

//#Preview {
//    MainroomView(enterteinment: .constant(20))
//}
