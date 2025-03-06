//
//  SearchView.swift
//  Assignment 3
//
//  Created by yunus on 06.03.2025.
//
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject var heroManager: HeroManager
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(heroManager.searchResult?.results ?? [], id: \.name) { hero in
                    SearchCellView(hero: hero, dataManager: DataManager())
                }
                .searchable(text: $searchText, prompt: "Search hero...")
                .onSubmit(of: .search) {
                    heroManager.searchHero(text: searchText)
                }
            }
        }
    }
}

struct SearchCellView: View {
    var hero: Hero2
    var dataManager: DataManager
    var body: some View {
        NavigationLink(destination: SearchDetailHero(hero: self.hero, dataManager: dataManager)) {
            VStack{
                HStack{
                    AsyncImage(url: URL(string: hero.image.url)) { phase in
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

struct SearchDetailHero: View {
    let hero: Hero2
    var dataManager: DataManager
    @State private var isFavorite: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                AsyncImage(url: URL(string: hero.image.url)) { phase in
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
                
                Button {
                    if isFavorite == false {
                        dataManager.addFavoriteHero2(hero: hero)
                    }
                    isFavorite = true
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
