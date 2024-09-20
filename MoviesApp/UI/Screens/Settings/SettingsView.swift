//
//  SettingsView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 19/09/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("General")) {
                SettingRow(text: "Notifications", icon: "bell") {
                    
                }
            }
            
            Section(header: Text("Support")) {
                SettingRow(text: "Report a bug", icon: "ladybug.circle.fill") {
                    NotificationCenter.default.post(name: .startVideoRecord, object: nil)
                }
                SettingRow(text: "Send Feedback", icon: "envelope.circle.fill") {
                    
                }
            }
        }
        .navigationTitle("Settings")
        .addCustomBackButton()
    }
}

struct SettingRow: View {
    let text: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(text)
                .poppins(.medium, 15)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    SettingsView()
}
