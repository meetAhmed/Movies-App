//
//  ReportBugView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 19/09/2024.
//

import SwiftUI

struct ReportBugView: View {
    @Injected var screenRecorder: MScreenRecorder!
    
    var body: some View {
        VStack(spacing: 25) {
            if let url = screenRecorder.videoUrl {
                VideoPlayerView(url: url)
                                .frame(height: 400)
                                .frame(width: UIScreen.main.bounds.width * 0.65)
                
                MButton("Submit Bug")
                    .disableBtn()
                    .frame(width: UIScreen.main.bounds.width * 0.65)
                    
                Text("Under development")
                    .poppins(.medium)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.appBackground)
    }
}
