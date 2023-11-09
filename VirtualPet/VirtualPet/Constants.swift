//
//  Constants.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import Foundation
import SwiftUI

//Constants
class Constants: ObservableObject {
    
    @Published var house: [String] = ["funIcon", "hungryIcon", "cleanIcon", "sleepIcon", "gardenIcon"]
    
    @Published var currentEnviroment: Enviroment = .mainroom
    
    @Published var badroomLightIsOn = true
    
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
    
    func needTaskDone (_ cb: VirtualPet, xp: Int32, friendship: Int32) {
        checkToEvolve(cb, xp)
        increaseFriendship(cb, friendship)
    }
    func checkToEvolve(_ cb: VirtualPet, _ xp: Int32) {
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
    func increaseFriendship (_ cb: VirtualPet, _ friendship: Int32) {
        cb.friendship += friendship
        if cb.friendship > 100 {
            cb.friendship = 100
        }
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
}

//App Delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//            print("App Did Launch!")
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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
//        print("SceneDelegate is connected!")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        let exitDate: Date = UserDefaults.standard.value(forKey: "exitDate") as? Date ?? .now
//        print(Date().description)
//        print("TIME INTERVAL", abs(exitDate.timeIntervalSince(Date())))
        let interval = abs(exitDate.timeIntervalSince(Date()))
        
        let entertainmet = Double(interval)/Double(Constants().timeToEntertainmentSec)
        let hungry = Double(interval)/Double(Constants().timeToHungerSec)
        let sleep = Double(interval)/Double(Constants().timeToSleepSec)
        let hygiene = Double(interval)/Double(Constants().timeToHygieneSec)

        if let user = users.first, let cb = user.getCurrentBuddy() {
            
            cb.entertainmet -= Int32(entertainmet)
            cb.sleep -= Int32(sleep)
            cb.hygiene -= Int32(hygiene)
            cb.hunger -= Int32(hungry)
            
            if (cb.entertainmet <= 0 && cb.sleep <= 0 && cb.hygiene <= 0 && cb.hunger <= 0) {
                let friendship = Double(interval)/Double(Constants().timeDecreaseFriendship)
                cb.friendship -= Int32(friendship) - Constants().greaterOf(list: [cb.entertainmet, cb.hygiene, cb.sleep, cb.hunger])
            }
            
            if cb.entertainmet - Int32(entertainmet) <= 0 {
                cb.entertainmet = 0
            }
            
            if cb.sleep - Int32(sleep) <= 0 {
                cb.sleep = 0
            }
            
            if cb.hygiene - Int32(hygiene) <= 0 {
                cb.hygiene = 0
            }
            
            if cb.hunger - Int32(hungry) <= 0 {
                cb.hunger = 0
            }
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error.localizedDescription)
            }
            Constants().objectWillChange.send()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        UserDefaults.standard.setValue(Date(), forKey: "exitDate")
//        print(Date().description)
    }
}
