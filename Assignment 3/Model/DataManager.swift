//
//  DataManager.swift
//  Assignment 3
//
//  Created by yunus on 06.03.2025.
//
import Foundation
import UIKit

final class DataManager: ObservableObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Published var heroes: [HeroEntity] = []
    
    init(){
        getAllHeroes()
    }
    
    func addFavoriteHero(hero: Hero){
        let newHero = HeroEntity(context: context)
        newHero.name = hero.name
        newHero.gender = hero.appearance.gender
        newHero.race = hero.appearance.race
        newHero.height = hero.appearance.height[1]
        newHero.weight = hero.appearance.weight[1]
        newHero.intelligence = Int16(hero.powerstats.intelligence)
        newHero.strength = Int16(hero.powerstats.strength)
        newHero.speed = Int16(hero.powerstats.speed)
        newHero.durability = Int16(hero.powerstats.durability)
        newHero.power = Int16(hero.powerstats.power)
        newHero.combat = Int16(hero.powerstats.combat)
        newHero.imageURL = hero.images.md
        
        saveContext()
        getAllHeroes()
    }
    
    func getAllHeroes(){
        let fetchingHeroes = HeroEntity.fetchRequest()
        do {
            heroes = try context.fetch(fetchingHeroes)
        } catch{
            print(error)
        }
    }
    
    func deleteHero(hero: HeroEntity){
        context.delete(hero)
        saveContext()
        getAllHeroes()
    }
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
