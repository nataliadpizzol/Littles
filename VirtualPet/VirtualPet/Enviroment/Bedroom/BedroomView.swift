//
//  BedroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct BedroomView: View {
    
    @State private var timer: Timer?
    
    @EnvironmentObject var constants: Constants
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        VStack{
            HStack{
                Image(constants.badroomLightIsOn ? "Pet1-happy" : "Pet1-sleep")
                    .resizable()
                    .frame(width: 270, height: 346)
                Rectangle()
                    .foregroundStyle(.gray)
                    //.stroke(.black, lineWidth: 2)
                    .frame(width: 30, height: 50)
                    .offset(x: 10)
                    
                    .onTapGesture {
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
                                        constants.needTaskDone(cb, xp: 10, friendship: 5)
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
                    }
            }
        }.background {
            Image("backgroundBed")
                .resizable()
                .frame(width: 400, height: 950)
                .offset(y: 50)
                
//            VStack(spacing: 0) {
//                Rectangle()
//                    .frame(width: 300, height: 150)
//                    .foregroundStyle(.indigo)
//                Rectangle()
//                    .frame(width: 300, height: 50)
//                    .foregroundStyle(.white)
//                Rectangle()
//                    .frame(width: 300, height: 350)
//                    .foregroundStyle(.mint)
//            }
        }
        .brightness(constants.badroomLightIsOn ? 0 : -0.5)
    }
}

#Preview {
    BedroomView()
}
