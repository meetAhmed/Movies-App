//
//  MLiveActivityViews.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 24/09/2024.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct MLiveActivityMinimal: View {
    var body: some View {
        Image(systemName: "popcorn.fill")
            .font(.largeTitle)
    }
}

struct MLiveActivityCompactLeading: View {
    let context: ActivityViewContext<MLiveActivityAttributes>
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "popcorn.fill")
                .font(.largeTitle)
            Text(context.attributes.movieTitle)
                .poppins(.medium)
                .bold()
        }
    }
}

struct MLiveActivityLeading: View {
    let context: ActivityViewContext<MLiveActivityAttributes>
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "popcorn.fill")
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text(context.attributes.movieTitle)
                    .poppins(.bold)
                Text(context.state.trailerState.desc)
                    .poppins(.medium)
                    .opacity(0.8)
            }
            .padding(.top, 8)
            .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.top, 4)
    }
}

struct MLiveActivityTrailing: View {
    var body: some View {
        Image(systemName: "lines.measurement.horizontal")
            .font(.largeTitle)
            .foregroundColor(.yellow)
    }
}

struct MLiveActivityBottom: View {
    let context: ActivityViewContext<MLiveActivityAttributes>
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "backward.fill")
                .font(.subheadline)
            ProgressView(value: context.state.trailerState.rawValue, total: Float(MLiveActivityAttributes.MovieTrailerState.allCases.count))
                .tint(Color.yellow)
            Image(systemName: "forward.fill")
                .font(.subheadline)
        }
        .padding()
    }
}

struct MLiveActivityLockView: View {
    let context: ActivityViewContext<MLiveActivityAttributes>
    
    var body: some View {
        VStack {
            HStack {
                MLiveActivityLeading(context: context)
                Spacer()
                MLiveActivityTrailing()
            }
            MLiveActivityBottom(context: context)
        }
        .padding()
    }
}
