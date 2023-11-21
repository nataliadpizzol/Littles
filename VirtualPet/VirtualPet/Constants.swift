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
    
    func needTaskDone (_ cb: VirtualPet, _ user: User, xp: Int32, friendship: Int32, coins: Int64) {
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
    
    private func checkToGetCoins(_ user: User, _ coins: Int64) {
        
        user.coins += coins
        if user.coins > 100 {
            user.coins = 100
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
