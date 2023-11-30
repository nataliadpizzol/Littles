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
    @State var petName = ""
    @State var friendshipValue: Int32 = 0
    @State var showSettings: Bool = false
    @State var navigateToProfile: Bool = false
    
    var petting: some Gesture {
        DragGesture()
            .onChanged { _ in
                if constants.vibration{
                    HapticManager.instance.impact(style: .soft)
                }
                if let cb = users.first?.getCurrentBuddy(), cb.entertainmet < 100 {
                    isPetting = true
                    cb.entertainmet = cb.entertainmet + 1
                    if cb.entertainmet == 100 {
                        if let user = users.first.self {
                            constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 1)
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
            ZStack {
                VStack {
                    Spacer()
                    HStack{
                        if constants.badroomLightIsOn{
                            ZStack{
                                ZStack {
                                    
                                    if self.isPetting {
                                        LottieView(name: "loveCicle")
                                            .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                    } else {
                                        Image(users.first?.getCurrentBuddy()?.entertainmet ?? 0 > 70 || self.isPetting ? "Pet1-happy" : "Pet1-sad")
                                            .resizable()
                                            .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                    }
                                    
                                    
                                    Image(users.first?.getCurrentBuddy()?.hygiene ?? 100 < 30 ? "Dirty3" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 60 ? "Dirty2" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 90 ? "Dirty1" : "")))
                                        .resizable()
                                        .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                    
                                    if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                                        Image(accessoryImage)
                                            .resizable()
                                            .frame(width: getProportionalValue(100, reader: reader), height: getProportionalValue(100, reader: reader))
                                            .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                            .scaleEffect(((users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Glasses"))! || (users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Guitar"))! || (users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Blanket"))!) ? 1.6 : 1)
                                            .onAppear{
                                                print("tem acessorio")
                                            }
                                    }
                                }
                                .position(x: 195, y: 42)
                                .gesture(petting)
                                .padding(.top, getProportionalValue(260, reader: reader))
                                
                                Image("Shadow")
                                    .resizable()
                                    .frame(width: 100, height: 30)
                                    .offset(y: 300)
                            }
                        }
                        else {
                            ZStack {
                                Image(users.first?.getCurrentBuddy()?.entertainmet ?? 0 > 70 || self.isPetting ? "Pet1-happy" : "Pet1-sad")
                                    .resizable()
                                    .frame(width: 270, height: 346)
                                if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                                    Image(accessoryImage)
                                        .resizable()
                                        .frame(width: getProportionalValue(100, reader: reader), height: getProportionalValue(100, reader: reader))
                                        .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                        .scaleEffect(((users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Glasses")) != nil) ? 1.6 : 0)
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
                    Spacer()
                    VStack {
                        HStack {
                            Button(action: {navigateToProfile = true},
                                   label: {Image("profileIcon")}
                            )
                            .buttonNavigation()
                            Spacer()
                            Button(action: {showSettings = true},
                                   label: {Image("settingsIcon")}
                            )
                            .buttonNavigation()
                        }
                        .padding()
                    }
                    TabbarView()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                }
                if showSettings {
                    SettingsComponent(showSettings: $showSettings)
                        .padding(EdgeInsets(top: 200, leading: 60, bottom: 200, trailing: 60))
                }
            }
            .navigationDestination(isPresented: $navigateToProfile, destination: {ProfileView(friendshipProgress: friendshipValue, level: "11").navigationBarBackButtonHidden()})
            .onAppear {
                if let cb = users.first?.getCurrentBuddy(){
                    petName = cb.name ?? ""
                    friendshipValue = cb.friendship
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}
