//
//  BedroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

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
                    Image(constants.badroomLightIsOn ? "Pet1-happy" : "Pet1-sleep")
                        .resizable()
                        .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(150, reader: reader))
                    Image(constants.badroomLightIsOn ? "BlanquetOn" : "BlanquetOff")
                        .resizable()
                        .offset(y: 410)
                        .frame(width: 400)
                    
                    VStack{
                        Button {
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
                        } label: {
                            Image(constants.badroomLightIsOn ? "lightOff" : "lightOn")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.buttonsText)
                        }
                        Button {
                            dismiss()
                        } label: {
                            Image("sleep")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.buttonsText)
                        }
                    }
                    .offset(x: 150, y: 200)
                    
                    #warning("COLOCAR O TIMER AQUI")
                }
                Spacer()
            }
                .background {
                Image(constants.badroomLightIsOn ? "backgroundBed" : "backgroundBedOff")
                    .resizable()
                    .frame(width: 400, height: 950)
                    .offset(y: 50)
                
            }
        }
        .navigationBarBackButtonHidden()
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}

#Preview {
    BedroomView()
}
