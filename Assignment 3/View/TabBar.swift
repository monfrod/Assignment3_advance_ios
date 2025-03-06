//
//  TabBar.swift
//  Assignment 3
//
//  Created by yunus on 06.03.2025.
//
import Foundation
import SwiftUI

struct TabBar: View {
    let heroManager = HeroManager()
    var body: some View {
        TabView{
            MainView(heroManager: heroManager, dataManager: DataManager())
                .tag(1)
                .tabItem {
                    VStack{
                        Image(systemName: "arrow.trianglehead.2.clockwise")
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
            SearchView(heroManager: heroManager)
                .tag(3)
                .tabItem {
                    VStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.red)
                        Text("Search hero")
                    }
                }
        }
    }
}
