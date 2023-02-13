//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
