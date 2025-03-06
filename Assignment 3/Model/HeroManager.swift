//
//  HeroManager.swift
//  Assignment 3
//
//  Created by yunus on 05.03.2025.
//
import Foundation

final class HeroManager: ObservableObject {
    
    @Published var selectedHero: Hero?
    
    func fetchHero(){
        guard let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json") else {return}
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("error in URLSession")
                return
            } else {
                guard let data = data else {return}
                do {
                    let heroes = try JSONDecoder().decode([Hero].self, from: data)
                    DispatchQueue.main.async {
                        self.selectedHero = heroes.randomElement()
                    }
                }
                catch {
                    print("error encoding: \(error)")
                }
            }
        }.resume()
        
    }
}


struct Hero: Codable {
    let name: String
    let powerstats: Powerstats
    let appearance: Appearance
    let images: Images
}

struct Appearance: Codable {
    let gender: String
    let race: String?
    let height: [String]
    let weight: [String]
}

struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Images: Codable {
    let xs: String
    let sm: String
    let md: String
    let lg: String
}


