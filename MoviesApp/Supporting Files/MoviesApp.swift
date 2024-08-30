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
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        MLogger.output("Detecting Jailbreak device: \(MDeviceProtection.shared.isJailbreakDevice())")
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
