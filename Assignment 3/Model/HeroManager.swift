//
//  HeroManager.swift
//  Assignment 3
//
//  Created by yunus on 05.03.2025.
//
import Foundation

final class HeroManager: ObservableObject {
    
    @Published var selectedHero: Hero?
    @Published var searchResult: SuperheroResponse?
    
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
    
    func searchHero(text: String){
        guard let url = URL(string: "https://www.superheroapi.com/api.php/3818e8b2996963335c726bcd09a7ebe9/search/\(text)") else {return}
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("error in URLSession")
                return
            } else {
                guard let data = data else {return}
                do {
                    let heroes = try JSONDecoder().decode(SuperheroResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.searchResult = heroes
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


struct SuperheroResponse: Codable {
    let response: String
    let resultsFor: String
    let results: [Hero2]
    
    enum CodingKeys: String, CodingKey {
        case response
        case resultsFor = "results-for"
        case results
    }
}

struct Hero2: Codable {
    let name: String
    let powerstats: Powerstats2
    let appearance: Appearance
    let image: Images2
}

struct Images2: Codable {
    let url: String
}

struct Powerstats2: Codable {
    let intelligence: String
    let strength: String
    let speed: String
    let durability: String
    let power: String
    let combat: String
}


