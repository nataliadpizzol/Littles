//
//  Classes.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 23/10/23.
//

import Foundation

class Pet {
    var description: String
    var photo: Data
    var specie: Specie
    var isKnown: Bool
    var index: Int
    var evolutionStage: EvolutionStage
    
    init(description: String, photo: Data, specie: Specie, index: Int, evolutionStage: EvolutionStage) {
        self.description = description
        self.photo = photo
        self.specie = specie
        self.isKnown = false
        self.index = index
        self.evolutionStage = evolutionStage
    }
    
    func sawPet() {
        isKnown = true;
    }
}

class VirtualPet: Pet {
    var name: String
    var birthday: Date
    var XP: (currentXP: Int, toEvolve: Int)
    var friendship: Int
    var sleep: Int
    var hunger: Int
    var hygiene: Int
    var entertainment: Int
    var favoriteFood: Itens
    var steps: Int
    var level: Int
    
    init(name: String, birthday: Date, XP: (Int, Int), friendship: Int, sleep: Int, hunger: Int, hygiene: Int, entertainment: Int, favoriteFood: Itens, steps: Int, description: String, photo: Data, specie: Specie, index: Int, evolutionStage: EvolutionStage) {
        self.name = name
        self.birthday = birthday
        self.XP = XP
        self.friendship = friendship
        self.sleep = sleep
        self.hunger = hunger
        self.hygiene = hygiene
        self.entertainment = entertainment
        self.favoriteFood = favoriteFood
        self.steps = steps
        self.level = 1
        super.init(description: description, photo: photo, specie: specie, index: index, evolutionStage: evolutionStage)
    }
    
    func nextLevel() {
        XP.currentXP = 0
        XP.toEvolve = XP.toEvolve * 5
        level += 1
    }
}

class User {
    var currentBuddy: VirtualPet
    var pets: [VirtualPet]
    var coins: Int
    var gems: Int
    var itens: [Itens]
    var firstLogin: Date
    var lastLogin: Date
    var streak: Int
    
    init(currentBuddy: VirtualPet, pets: [VirtualPet], coins: Int, gems: Int, itens: [Itens], firstLogin: Date, lastLogin: Date, streak: Int) {
        self.currentBuddy = currentBuddy
        self.pets = pets
        self.coins = coins
        self.gems = gems
        self.itens = itens
        self.firstLogin = firstLogin
        self.lastLogin = lastLogin
        self.streak = streak
    }
}

class Itens {
    var name: String
    var photo: Data
    var price: Int
    var type: ItemType
    var description: String
    
    init(name: String, photo: Data, price: Int, type: ItemType, description: String) {
        self.name = name
        self.photo = photo
        self.price = price
        self.type = type
        self.description = description
    }
}
