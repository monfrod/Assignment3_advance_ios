//
//  MainView.swift
//  Assignment 3
//
//  Created by yunus on 28.02.2025.
//
import SwiftUI

struct MainView: View {
    
    @ObservedObject var heroManager: HeroManager
    @ObservedObject var dataManager: DataManager
    @State private var isFavorite: Bool = false
    
    var body: some View {
        var hero = heroManager.selectedHero
        ScrollView(showsIndicators: false) {
            VStack {
                AsyncImage(url: URL(string: heroManager.selectedHero?.images.md ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Color.black
                    case .success(let image):
                        image
                    case .failure(let error):
                        Color.red
                    }
                }
                .frame(width: 300, height: 400)
                .cornerRadius(20)
                .padding()
                .clipped()
    
                if let hero = heroManager.selectedHero {
                    Text("Name: \(hero.name)")
                        .font(.title)
                        .bold()
                    
                    Text("Gender: \(hero.appearance.gender)")
                        .foregroundColor(.gray)
                    
                    Text("Race: \(hero.appearance.race ?? "Unknown")")
                        .foregroundColor(.gray)
                    
                    Text("Height: \(hero.appearance.height.joined(separator: ", "))")
                        .foregroundColor(.gray)
                    
                    Text("Weight: \(hero.appearance.weight.joined(separator: ", "))")
                        .foregroundColor(.gray)
                    
                    Text("Intelligence: \(hero.powerstats.intelligence)")
                        .foregroundColor(.blue)
                    
                    Text("Strength: \(hero.powerstats.strength)")
                        .foregroundColor(.blue)
                    
                    Text("Speed: \(hero.powerstats.speed)")
                        .foregroundColor(.blue)
                    
                    Text("Durability: \(hero.powerstats.durability)")
                        .foregroundColor(.blue)
                    
                    Text("Power: \(hero.powerstats.power)")
                        .foregroundColor(.blue)
                    
                    Text("Combat: \(hero.powerstats.combat)")
                        .foregroundColor(.blue)
                }
                
                HStack{
                    Button {
                        heroManager.fetchHero()
                        isFavorite = false
                    } label: {
                        Text("Roll")
                            .padding(.horizontal, 80)
                            .padding(.vertical)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(20)
                    }
                    Button {
                        guard let hero = hero else {return}
                        if isFavorite == false {
                            dataManager.addFavoriteHero(hero: hero)
                        }
                        isFavorite.toggle()
                        print("add to favorites: \(isFavorite)")
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(isFavorite ? .red : .blue)
                    }
                }
                
            }
        }
    }
}

#Preview {
    MainView(heroManager: HeroManager(), dataManager: DataManager())
}
