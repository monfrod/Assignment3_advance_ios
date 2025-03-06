//
//  TabBar.swift
//  Assignment 3
//
//  Created by yunus on 06.03.2025.
//
import Foundation
import SwiftUI

struct TabBar: View {
    
    var body: some View {
        TabView{
            MainView(heroManager: HeroManager(), dataManager: DataManager())
                .tag(1)
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                        Text("Heroes")
                    }
                }
            SavedView()
                .tag(2)
                .tabItem {
                    VStack{
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        Text("Favorites")
                    }
                }
        }
    }
}
