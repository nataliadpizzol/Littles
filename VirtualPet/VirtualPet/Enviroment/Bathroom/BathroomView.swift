import SwiftUI
import SpriteKit

struct BathroomView: View {
    
    @GestureState var tap = CGPoint(x: 200, y: 100)
    var tapPos = CGPoint(x: 200, y: 100)
    @State var tapLocation = CGPoint(x: 200, y: 100)
    @State private var lather = false
    @State private var water = false
    @State private var finishShower: Int = 0
    @EnvironmentObject var constants: Constants
    @State private var offset = CGPoint()
    @State var timer: Timer?
    @State var aux: Int = 0
    @State var bubblePos: [CGPoint] = []
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    //checks if the gesture of shower is happening so the water particles can be showned
    @State private var isTouchingShower = false
    
    //spriteKit scene
    var waterScene: SKScene {
        let scene = WaterScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    
    var soap: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if let cb = users.first?.getCurrentBuddy(), cb.hygiene < 100 {
                    offset = gesture.location
//                    if cb.hygiene % 10 == 0 {
//                        aux = Int(cb.hygiene)
//                        bubblePos.append(offset)
//                    }
                    if constants.vibration{
                        HapticManager.instance.impact(style: .soft)
                    }
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
                self.isTouchingShower = true
                tapLocation = state.location
                if finishShower > 0 {
                    self.water = true
                    self.finishShower = self.finishShower - 1
                    if self.finishShower == 0 {
                        if let cb = users.first?.getCurrentBuddy(){
                            if let user = users.first.self {
                                constants.needTaskDone(cb, user, xp: 10, friendship: 5, coins: 1)
                            }
                        }
                    }
                }
                else {
                    self.water = false
                }
            }
            .onEnded { _ in
                self.isTouchingShower = false
                self.water = false
                tapLocation = tapPos
                
            }
            .updating($tap, body: { currentState, pastLocation, transaction in
                pastLocation = currentState.location
            })
    }
    
    var body: some View {
        GeometryReader { reader in
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    ZStack{
                        if constants.badroomLightIsOn {
                            Image(users.first?.getCurrentBuddy()?.hygiene ?? 100 < 30 ? "Pet1-Dirty3" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 60 ? "Pet1-Dirty2" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 90 ? "Pet1-Dirty1" : (finishShower == 0 ? "Pet1-happy" : "Pet1-OK"))))
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                .gesture(soap)
                            Image("Shadow")
                                .resizable()
                                .frame(width: 100, height: 30)
                                .offset(y: 250)
                            if lather {
                                Image("soap")
                                    .resizable()
                                    .frame(width: getProportionalValue(60, reader: reader), height: getProportionalValue(40, reader: reader))
                                    .offset(x: offset.x-150, y: offset.y-75)
                            }
//                          if finishShower > 0 {
//                              if aux > 10 {
//                                  Image("bubble")
//                                      .resizable()
//                                      .frame(width: getProportionalValue(60, reader: reader), height: getProportionalValue(40, reader: reader))
//                                      .offset(x: bubblePos[0].x-150, y: bubblePos[0].y-75)
//                              }
//                          }
                        }
                        else {
                            Image("Pet1-happy")
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                                .hidden()
                        }
                        
                        if isTouchingShower {
                            //creates a sprite view that showes the water scene
                            SpriteView(scene: waterScene, options: [.allowsTransparency])
                                .frame(width: 100, height: 500)
                                .position(CGPoint(x: tap.x, y: 320)) //x postion of the water is the same as the x position of the shower gesture
                        }
                        
                        if let cb = users.first?.getCurrentBuddy(), cb.hygiene == 100 {
                            Image("shower")
                                .resizable()
                                .frame(width: 100, height: 200)
                                .position(CGPoint(x: tap.x, y: -13)) //x postion of the circle is the same as the x position of the shower gesture
                                .gesture(shower)
                        }
                    }
                    .brightness(constants.badroomLightIsOn ? 0 : -0.5)
                    VStack {
                        HStack {
                            Button(action: {}, label: {Image( "soapIcon")})
                                .buttonNavigation()
                            Spacer()
                            Button(action: {}, label: {Image( "waterIcon")})
                                .buttonNavigation()
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 17, trailing: 17))
                    }
                    .hidden()
                    TabbarView()
                        .padding(EdgeInsets(top: 0, leading: -6, bottom: 40, trailing: 0))
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension BathroomView {
    //spriteKit scnece with the water particles
    class WaterScene: SKScene {
        
        let waterEmitterNode = SKEmitterNode(fileNamed: "WaterParticle.sks")
        
        override func didMove(to view: SKView) {
            guard let waterEmitterNode = waterEmitterNode else { return }
            waterEmitterNode.particleSize = CGSize(width: 50, height: 100)
            waterEmitterNode.particleLifetime = 100
            waterEmitterNode.particleLifetimeRange = 100
            addChild(waterEmitterNode)
        }
        
        override func didChangeSize(_ oldSize: CGSize) {
            guard let waterEmitterNode = waterEmitterNode else { return }
            waterEmitterNode.particlePosition = CGPoint(x: size.width/2, y: size.height)
            waterEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        }
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}
