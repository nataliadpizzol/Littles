import SwiftUI

struct KitchenView: View {
    
    @GestureState var plate = CGPoint(x: 200, y: 600)
    @State var foodLocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5)
    @State var toEat = true
    @State var isEating = false
    @State var food: String = ""
    var mouth = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 1.8 * UIScreen.main.bounds.height/3)
    var platePos = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5)
    @EnvironmentObject var constants: Constants
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    @State var navigateToFridge: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                ZStack {
                    if constants.badroomLightIsOn{
                        Circle()
                            .foregroundStyle(.red)
                            .frame(width: 50, height: 50)
                            .position(mouth)
                        ZStack {
                            
                            if self.isEating {
                                Image("Pet1-eat")
                                    .resizable()
                                    .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                    .offset(y: getProportionalValue(40, reader: reader))
                                
                            } else {
                                if users.first?.getCurrentBuddy()?.hunger ?? 100 < 50 {
                                    LottieView(name: "eatCicle")
                                        .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                        .offset(y: getProportionalValue(40, reader: reader))
                                } else {
                                    Image("Pet1-happy")
                                        .resizable()
                                        .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                        .offset(y: getProportionalValue(40, reader: reader))
                                    
                                }
                            }
                            Image(users.first?.getCurrentBuddy()?.hygiene ?? 100 < 30 ? "Dirty3" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 60 ? "Dirty2" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 90 ? "Dirty1" : "")))
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                .offset(y: getProportionalValue(40, reader: reader))
                        }
                    }
                    else {
                        Circle()
                            .foregroundStyle(.red)
                            .frame(width: 50, height: 50)
                            .position(mouth)
                            .hidden()
                        Image(self.isEating ? "Pet1-eat" : "Pet1-happy")
                            .resizable()
                            .frame(width: 270, height: 346)
                            .hidden()
                    }
                    VStack {
                        Spacer()
                        ZStack{
                            Image("tableKitchen")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: getProportionalValue(250, reader: reader))
                                .offset(x: getProportionalValue(-10, reader: reader),y:getProportionalValue(90, reader: reader))
                            Image("Plate")
                                .resizable()
                                .frame(width: getProportionalValue(200, reader: reader), height: getProportionalValue(90, reader: reader))
                                .offset(y:getProportionalValue(100, reader: reader))
                        }
                    }
                    VStack{
                        if toEat && constants.badroomLightIsOn{
                            Image(food)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .position(foodLocation)
                                .foregroundStyle(.orange)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ state in
                                            self.isEating = true
                                            foodLocation = state.location
                                            if (foodLocation.x >= mouth.x - 20 && foodLocation.x <= mouth.x + 20 && foodLocation.y >= mouth.y - 20 && foodLocation.y <= mouth.y + 20) {
                                                if constants.vibration{
                                                    HapticManager.instance.impact(style: .heavy)
                                                }
                                                toEat = false
                                                isEating = false
                                                deleteFood(photo: food)
                                                if let cb = users.first?.getCurrentBuddy(), cb.hunger < 100 {
                                                    cb.hunger = 100
                                                    if let user = users.first.self {
                                                        constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 1)
                                                    }
                                                    do {
                                                        try managedObjectContext.save()
                                                    } catch {
                                                        print(error.localizedDescription)
                                                    }
                                                }
                                                constants.objectWillChange.send()
                                            }
                                            
                                        })
                                        .onEnded({ state in
                                            self.isEating = false
                                            withAnimation {
                                                foodLocation = platePos
                                            }
                                        })
                                        .updating($plate, body: { currentState, pastLocation, transaction in
                                            pastLocation = currentState.location
                                        })
                                )
                        }
                    }
                }
                .brightness(constants.badroomLightIsOn ? 0 : -0.5)
                VStack {
                    HStack {
                        Button(action: {navigateToFridge = true},
                               label: {Image("fridgeIcon")}
                        )
                        .buttonNavigation()
                        Spacer()
                    }
                    .padding()
                    .padding(.leading, 8)
                    TabbarView()
                }
                .padding(EdgeInsets(top: 0, leading: -15, bottom: 40, trailing: 0))
            }
        }
        .navigationDestination(isPresented: $navigateToFridge, destination: {FridgeView(food: $food)})
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
    func deleteFood(photo: String) {
        if let itens = users.first?.itemsArray {
            for item in itens {
                if item.photo == photo {
                    users.first?.removeFromItems(item)
                    return
                }
            }
        }
    }
}
