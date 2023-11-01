//
//  Constants.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import Foundation
import SwiftUI

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
