import Foundation
import SwiftUI
import AVFoundation

//Constants
class Constants: ObservableObject {
    
    @Published var currentEnviroment: Enviroment = .mainroom
    
    @Published var selectedItem: Item? = nil
    
    @Published var currentWardrobe: Wardrobe = .glasses {
        didSet {
            switch currentWardrobe {
            case .glasses:
                isGlassesActive = true
                isHandBodyActive = false
                isHatActive = false
            case .handBody:
                isGlassesActive = false
                isHandBodyActive = true
                isHatActive = false
            case .hat:
                isGlassesActive = false
                isHandBodyActive = false
                isHatActive = true
            }
        }
    }
    
    
    @Published var isGlassesActive: Bool = true
    @Published var isHandBodyActive: Bool = false
    @Published var isHatActive: Bool = false

    @Published var badroomLightIsOn = true
    @Published var timerSleep: Timer?
    
    @Published var timerDecreaseEntertainment: Timer?
    @Published var timerDecreaseHunger: Timer?
    @Published var timerDecreaseHygiene: Timer?
    @Published var timerDecreaseSleep: Timer?
    @Published var timerDecreaseFriendship: Timer?
    
    let timeToEntertainmentSec = 180
    let timeToHungerSec = 126
    let timeToHygieneSec = 90
    let timeToSleepSec = 252
    
    let timeDecreaseFriendship = 3600
    
    func needTaskDone (_ cb: VirtualPet, _ user: User, xp: Int32, friendship: Int32, coins: Int64) {
        if vibration{
            HapticManager.instance.impact(style: .heavy)
        }
        checkToEvolve(cb, xp)
        increaseFriendship(cb, friendship)
        checkToGetCoins(user, coins)
    }

    
    // adicionar aqui
    
    private func checkToEvolve(_ cb: VirtualPet, _ xp: Int32) {
//        print("JORGE XP++")

        cb.currentXP += xp
        if cb.currentXP >= cb.xpToEvolve {
            cb.currentXP -= cb.xpToEvolve
            cb.level += 1
            cb.xpToEvolve = cb.xpToEvolve + (cb.level * 10)
        }
        
        /*
        if cb.level == /*value 1 stage to 2*/ {
            cb.evolutionStage =
            cb.photo =
        }
        if cb.level == /*value 2 stage to 3*/ {
            cb.evolutionStage =
            cb.photo =
        }
        */
    }
    
    private func increaseFriendship (_ cb: VirtualPet, _ friendship: Int32) {
        cb.friendship += friendship
        if cb.friendship > 100 {
            cb.friendship = 100
        }
    }
    
    func checkToGetCoins(_ user: User, _ coins: Int64) {
        user.coins += coins
    }
    
    func greaterOf(list: [Int32]) -> Int32 {
        var greater: Int32 = list[0]
        list.forEach { number in
            if number >= greater {
                greater = number
            }
        }
        return greater
    }
    
    //Settings vars
    
    @Published var audioPlayer: AVAudioPlayer?
    
    @Published var vibration: Bool = UserDefaults.standard.value(forKey: "vibration") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(vibration, forKey: "vibration")
        }
    }
    @Published var music: Bool = UserDefaults.standard.value(forKey: "music") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(music, forKey: "music")
            if music {
                playAudio(audio: badroomLightIsOn ? "backgroundSound" : "sleepSound")
            }
            else {
                audioPlayer?.stop()
            }
        }
    }
    
    func playAudio(audio: String) {
        if let audioURL = Bundle.main.url(forResource: audio, withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioURL) /// make the audio player
                audioPlayer?.play() /// start playing
                audioPlayer?.numberOfLoops = Int.max
                
            } catch {
                print("JORGE Couldn't play audio. Error: \(error)")
            }
            
        } else {
            print("JORGE No audio file found")
        }
    }
    
}

//App Delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//            print("JORGE App Did Launch!")
            return true
        }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

//Scene Delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @EnvironmentObject var constants: Constants
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
//        print("JORGE SceneDelegate is connected!")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        UserDefaults.standard.setValue(true, forKey: "enteredApp")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        UserDefaults.standard.setValue(Date(), forKey: "exitDate")
//        print(Date().description)
    }
}
