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
    
    let timeToEntertainmentSec = 180
    let timeToHungerSec = 126
    let timeToHygieneSec = 90
    let timeToSleepSec = 252
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
//        print(abs(exitDate.timeIntervalSince(Date())))
        let interval = abs(exitDate.timeIntervalSince(Date()))
        
        let entertainmet = Double(interval)/Double(Constants().timeToEntertainmentSec)
        let hungry = Double(interval)/Double(Constants().timeToHungerSec)
        let sleep = Double(interval)/Double(Constants().timeToSleepSec)
        let hygiene = Double(interval)/Double(Constants().timeToHygieneSec)

        if let user = users.first, let cb = user.getCurrentBuddy() {
            cb.entertainmet -= Int32(entertainmet)
            if cb.entertainmet <= 0 {
                cb.entertainmet = 0
            }
            
            cb.sleep -= Int32(sleep)
            if cb.sleep <= 0 {
                cb.sleep = 0
            }
            
            cb.hygiene -= Int32(hygiene)
            if cb.hygiene <= 0 {
                cb.hygiene = 0
            }
            
            cb.hunger -= Int32(hungry)
            if cb.hunger <= 0 {
                cb.hunger = 0
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        UserDefaults.standard.setValue(Date(), forKey: "exitDate")
//        print(Date().description)
    }
}
