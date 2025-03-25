//
//  MTabsView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/03/2025.
//

import SwiftUI

struct MTabsView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.primary)
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .tint(.white)
    }
}
