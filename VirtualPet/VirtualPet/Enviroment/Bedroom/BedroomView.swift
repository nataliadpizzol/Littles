// ONDE O LITTLE DORME

import SwiftUI

struct BedroomView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var timer: Timer?
    
    @EnvironmentObject var constants: Constants
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                Spacer()
                ZStack {
                    Image(constants.badroomLightIsOn ? (users.first?.getCurrentBuddy()?.sleep ?? 0 > 70 ? "Pet1-happy" : "Pet1-OK") : "Pet1-sleep")
                        .resizable()
                        .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(150, reader: reader))
                    Image(users.first?.getCurrentBuddy()?.hygiene ?? 100 < 30 ? "Dirty3" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 60 ? "Dirty2" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 90 ? "Dirty1" : "")))
                        .resizable()
                        .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(150, reader: reader))
                        .offset(y: getProportionalValue(10, reader: reader))
                    Image(constants.badroomLightIsOn ? "BlanquetOn" : "BlanquetOff")
                        .resizable()
                        .offset(y: getProportionalValue(430, reader: reader))
                        .frame(width: getProportionalValue(400, reader: reader))
                    
                    VStack{
                        Button(
                            action: {
                                constants.badroomLightIsOn.toggle()
                                if let cb = users.first?.getCurrentBuddy(){
                                    if constants.badroomLightIsOn {
                                        timer?.invalidate()
                                        timer = nil
                                    }
                                    else {
                                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: cb.sleep < 100) { _ in
                                            cb.sleep += 1
                                            if cb.sleep == 100 {
                                                if let user = users.first.self {
                                                    constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 5)
                                                }
                                            }
                                            do {
                                                try managedObjectContext.save()
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                            constants.objectWillChange.send()
                                        }
                                    }
                                }
                            },
                           label: {Image(constants.badroomLightIsOn ? "lightOffIcon" : "lightOnIcon")}
                        )
                        .buttonNavigation()
                        
                        Button(action: { dismiss()}, 
                               label: {Image("bedIcon")}
                        )
                            .buttonBack()
                            .frame(width: 50, height: 50)
                    }
                    .offset(x: getProportionalValue(150, reader: reader), y: getProportionalValue(200, reader: reader))
                    
                    #warning("COLOCAR O TIMER AQUI")
                }
                Spacer()
            }
                .background {
                Image(constants.badroomLightIsOn ? "backgroundBed" : "backgroundBedOff")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width + getProportionalValue(10, reader: reader), height: UIScreen.main.bounds.height + getProportionalValue(15, reader: reader))
                    .offset(x: getProportionalValue(-2, reader: reader), y: getProportionalValue(-10, reader: reader))
                
            }
        }
        .navigationBarBackButtonHidden()
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}
