//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI
import Combine
import AVFoundation
import AVKit

@main
struct MoviesApp: App {
    @StateObject private var vm = HomeViewModel()
    @State private var showOverlay = false
    @State private var timerCancellable: Cancellable?
    @State private var time = 1
    @Injected var screenRecorder: MScreenRecorder!
    
    init() {
        configureURLCache()
    }
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if showOverlay {
                    HStack(alignment: .center) {
                        Text("Recording screen")
                            .poppins(.medium, 15)
                        Text("\(time) sec")
                            .poppins(.light, 14)
                        Spacer()
                        HStack {
                            Text("Stop")
                                .poppins(.medium, 15)
                            Image(systemName: "stop.circle.fill")
                        }
                        .onTapGesture {
                            Task {
                                do {
                                    try await screenRecorder.stop()
                                } catch {
                                    print(error)
                                    showOverlay = false
                                }
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.primary)
                    )
                    .padding()
                    
                    Spacer()
                }
                MTabsView()
                    .environmentObject(vm)
            }
            .onReceive(NotificationCenter.default.publisher(for: .startVideoRecord)) { _ in
                do {
                    try screenRecorder.record()
                } catch {
                    print(error)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .screenRecordingStarted)) { _ in
                showOverlay = true
                timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        time += 1
                    }
            }
            .onReceive(NotificationCenter.default.publisher(for: .screenRecordingStopped)) { _ in
                showOverlay = false
                timerCancellable?.cancel()
                timerCancellable = nil
                time = 0
                
                UIApplication.shared.topViewController()?.present(UIHostingController(rootView: ReportBugView()), animated: true)
            }
        }
    }
}

private extension MoviesApp {
    func configureURLCache() {
        let memoryCapacity = 40 * 1024 * 1024
        let diskCapacity = 80 * 1024 * 1024
        URLCache.shared = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
    }
}
