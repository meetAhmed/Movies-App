//
//  MLoadingView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import SwiftUI

struct MLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(Color.primary)
            .frame(height: 25)
    }
}
