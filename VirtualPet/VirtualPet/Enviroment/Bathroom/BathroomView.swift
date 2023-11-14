import SwiftUI

struct BathroomView: View {
    
    //    @Binding var clean: Int
    @GestureState var tap = CGPoint(x: 200, y: 100)
    var tapPos = CGPoint(x: 200, y: 100)
    @State var tapLocation = CGPoint(x: 200, y: 100)
    @State private var lather = false
    @State private var water = false
    @State private var finishShower: Int = 0
    @EnvironmentObject var constants: Constants
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var soap: some Gesture {
        DragGesture()
            .onChanged { _ in
                if let cb = users.first?.getCurrentBuddy(), cb.hygiene < 100 {
                    self.lather = true
                    cb.hygiene = cb.hygiene + 1
                    self.finishShower = self.finishShower + 1
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                else {
                    self.lather = false
                }
                constants.objectWillChange.send()
            }
            .onEnded { _ in
                self.lather = false
            }
    }
    
    var shower: some Gesture {
        DragGesture()
            .onChanged { state in
                tapLocation = state.location
                if finishShower > 0 {
                    self.water = true
                    self.finishShower = self.finishShower - 1
                    if self.finishShower == 0 {
                        if let cb = users.first?.getCurrentBuddy(){
                            if let user = users.first.self {
                                constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 5)
                            }
                        }
                    }
                }
                else {
                    self.water = false
                }
            }
            .onEnded { _ in
                tapLocation = tapPos
                self.water = false
            }
            .updating($tap, body: { currentState, pastLocation, transaction in
                pastLocation = currentState.location
            })
    }
    
    var body: some View {
        VStack {
            
            ZStack{
                if let cb = users.first?.getCurrentBuddy(), cb.hygiene == 100 {
                    HStack{
                        Circle()
                            .foregroundStyle(self.water ? .red : .blue)
                            .frame(width: 200, height: 200)
                            .position(tapLocation)
                            .gesture(shower)
                    }
                } else {
                    Spacer()
                }
            }
            Image("Pet1-happy")
                .resizable()
                .frame(width: 270, height: 346)
                .gesture(soap)
            
            //            Rectangle()
            //                .foregroundStyle(self.lather ? .red : ((self.finishShower == 0 && users.first?.getCurrentBuddy()!.hygiene == 100) ? .green : .blue))
            //                .frame(width: 200, height: 200)
            //                .gesture(soap)
            
            
            Spacer()
            
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BathroomView()
}
