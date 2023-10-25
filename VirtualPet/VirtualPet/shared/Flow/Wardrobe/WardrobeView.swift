//
//  WardrobeView.swift
//  VirtualPet
//
//  Created by Maria Luísa Lamb Souto on 25/10/23.
//

import SwiftUI

struct WardrobeView: View {
    
    //    let listAcessories: [acessories] = []
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Wardrobe")
                        .padding(.top, 60)
                        .font(.cherryBombOne(.regular, size: 30))
                }
                Group{
                    HStack{
                        ZStack{
                            Image("WardrobeAccessory1")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 30)
                        }
                        .onTapGesture {}
                        ZStack{
                            Image("WardrobeAccessory2")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 30)
                        }
                        .onTapGesture {}
                        
                        ZStack{
                            Image("WardrobeAccessory3")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .onTapGesture {}
                        
                    }
                    .padding(.top, 120)
                    HStack{
                        ZStack{
                            Image("WardrobeAccessory4")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 30)
                        }
                        .onTapGesture {}
                        
                        ZStack{
                            Image("")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 30)
                        }
                        ZStack{
                            Image("")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding(.top, 50)
                    Spacer()
                }
            }
        }
        .background(
            Image("WardrobeBackgroud")
            //                            .resizable()
            //                            .frame(maxWidth: 00, maxHeight: 300)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    WardrobeView()
}
