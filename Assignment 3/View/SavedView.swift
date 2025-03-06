//
//  HeroRandomizer.swift
//  Assignment 3
//
//  Created by yunus on 28.02.2025.
//
import SwiftUI

struct SavedView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: 0)
    ]
    @ObservedObject var dataManager = DataManager()
    
    var body: some View {
        NavigationStack{
            ScrollView (showsIndicators: false){
                LazyVGrid(columns: columns) {
                    ForEach(dataManager.heroes, id: \.self) { hero in
                        CellView(hero: hero, dataManager: dataManager)
                    }
                }
            }
            .onAppear{
                dataManager.getAllHeroes()
            }
        }
    }
}



struct CellView: View {
    var hero: HeroEntity
    var dataManager: DataManager
    var body: some View {
        NavigationLink(destination: DetailHero(hero: self.hero, dataManager: dataManager)) {
            VStack{
                HStack{
                    AsyncImage(url: URL(string: hero.imageURL)) { phase in
                        switch phase {
                        case .empty:
                            Color.black
                        case .success(let image):
                            image
                        case .failure(let error):
                            Color.red
                        }
                    }
                    .frame(width: 200, height: 280)
                    .clipped()
                    .cornerRadius(20)
                    .padding(10)
                    Spacer()
                    Text(hero.name ?? "Unknown name")
                    Spacer()
                }
            }
        }

    }
}

struct DetailHero: View {
    let hero: HeroEntity
    var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                AsyncImage(url: URL(string: hero.imageURL)) { phase in
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
                
                Text("Name: \(hero.name ?? "Unknown")")
                    .font(.title)
                    .bold()
                
                Text("Gender: \(hero.gender ?? "Unknown")")
                    .foregroundColor(.gray)
                
                Text("Race: \(hero.race ?? "Unknown")")
                    .foregroundColor(.gray)
                
                Text("Height: \(hero.height ?? "Unknown")")
                    .foregroundColor(.gray)
                
                Text("Weight: \(hero.weight ?? "Unknown")")
                    .foregroundColor(.gray)
                
                Text("Intelligence: \(hero.intelligence)")
                    .foregroundColor(.blue)
                
                Text("Strength: \(hero.strength)")
                    .foregroundColor(.blue)
                
                Text("Speed: \(hero.speed)")
                    .foregroundColor(.blue)
                
                Text("Durability: \(hero.durability)")
                    .foregroundColor(.blue)
                
                Text("Power: \(hero.power)")
                    .foregroundColor(.blue)
                
                Text("Combat: \(hero.combat)")
                    .foregroundColor(.blue)
                Button {
                    dataManager.deleteHero(hero: self.hero)
                    dismiss()
                } label: {
                    Text("Delete")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(.red)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }

            }
        }
    }
}

//#Preview{
//    CellView(hero: HeroEntity())
//}
