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
                self.isTouchingShower = true
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
                self.isTouchingShower = false
                self.water = false
                tapLocation = tapPos
                
            }
            .updating($tap, body: { currentState, pastLocation, transaction in
                pastLocation = currentState.location
            })
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                
                Image("Pet1-happy")
                    .resizable()
                    .frame(width: 270, height: 346)
                    .gesture(soap)
                
                if isTouchingShower {
                    //creates a prite view that showes the water scene
                    SpriteView(scene: waterScene, options: [.allowsTransparency])
                        .frame(width: 100, height: 500)
                        .position(CGPoint(x: tap.x, y: 320)) //x postion of the water is the same as the x position of the shower gesture
                }
                
                if let cb = users.first?.getCurrentBuddy(), cb.hygiene == 100 {
                    Circle()
                        .foregroundStyle(.gray)
                        .frame(width: 100)
                        .position(CGPoint(x: tap.x, y: 50)) //x postion of the circle is the same as the x position of the shower gesture
                        .gesture(shower)
                }
                if constants.badroomLightIsOn {
                    Image("Pet1-happy")
                        .resizable()
                        .frame(width: 270, height: 346)
                        .gesture(soap)
                }
                else {
                    Image("Pet1-happy")
                        .resizable()
                        .frame(width: 270, height: 346)
                        .gesture(soap)
                        .hidden()
                }
                
                //            Rectangle()
                //                .foregroundStyle(self.lather ? .red : ((self.finishShower == 0 && users.first?.getCurrentBuddy()!.hygiene == 100) ? .green : .blue))
                //                .frame(width: 200, height: 200)
                //                .gesture(soap)
                
            }
            .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            Spacer()
            
            TabbarView()
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
}
