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
                        if let user = users.first.self {
                            constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 5)
                        }                    }
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
        GeometryReader { reader in
            VStack {
                HStack{
                    if constants.badroomLightIsOn{
                        ZStack {
                            Image(users.first?.getCurrentBuddy()?.entertainmet ?? 0 > 70 || self.isPetting ? "Pet1-happy" : "Pet1-sad")
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(150, reader: reader))
                            if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                                Image(accessoryImage)
                                    .resizable()
                                    .frame(width: getProportionalValue(100, reader: reader), height: getProportionalValue(100, reader: reader))
                                    .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                    .onAppear{
                                        print("tem acessorio")
                                    }
                            }
                        }
                        .gesture(petting)
                        .padding(.top, getProportionalValue(260, reader: reader))
                    }
                    else {
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
                        .hidden()
                    }
                }
                .brightness(constants.badroomLightIsOn ? 0 : -0.5)
                .onAppear {
                    //Using user default to validate first access to the app
                    UserDefaults.standard.set(false, forKey: "firstTimeHere")
                    
                    // Change Later
                    //                users.first?.getCurrentBuddy()?.currentAccessoryImageName = "WardrobeAccessory1"
                    //                users.first?.getCurrentBuddy()?.accessoryPositionX = "140"
                    //                users.first?.getCurrentBuddy()?.accessoryPositionY = "20"
                    //
                    //                do {
                    //                    try managedObjectContext.save()
                    //                } catch {
                    //                    print(error.localizedDescription)
                    //                }
                    //                print(users.first?.getCurrentBuddy()?.currentAccessoryImageName)
                    //                print(users.first?.getCurrentBuddy()?.accessoryPositionX)
                }
                Spacer()
                HStack {
                    Spacer()
                    TabbarView()
                        .padding()
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}

//#Preview {
//    MainroomView(enterteinment: .constant(20))
//}
