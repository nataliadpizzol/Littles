//
//  MainroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 25/10/23.
//

import SwiftUI

struct MainroomView: View {
    
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
                    print(cb.entertainmet)
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
                    Circle()
                        .foregroundStyle(self.isPetting ? .red : .blue)
                        .frame(width: 200, height: 200)
                        .gesture(petting)
                }
            
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    MainroomView(enterteinment: .constant(20))
//}
