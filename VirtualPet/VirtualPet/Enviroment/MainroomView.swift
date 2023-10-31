//
//  MainroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 25/10/23.
//

import SwiftUI

struct MainroomView: View {
    
    @Binding var enterteinment: Int
    @State var isPetting: Bool = false
    
    var petting: some Gesture {
        DragGesture()
            .onChanged { _ in
                if enterteinment < 100 {
                    isPetting = true
                    self.enterteinment = self.enterteinment + 1
                    print(self.enterteinment)
                }
                else {
                    self.isPetting = false
                }
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

#Preview {
    MainroomView(enterteinment: .constant(20))
}
