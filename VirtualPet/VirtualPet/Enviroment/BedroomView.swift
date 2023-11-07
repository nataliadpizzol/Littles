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
            Text("Bedroom")
            HStack{
                Rectangle()
                    .foregroundStyle(.blue)
                    .frame(width: 300, height: 300)
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 50)
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
            .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BedroomView()
}
