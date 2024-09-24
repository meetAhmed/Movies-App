//
//  MLiveActivityHandler.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 24/09/2024.
//

import ActivityKit

class MLiveActivityHandler {
    private let attributes: MLiveActivityAttributes
    private var liveActivity: Activity<MLiveActivityAttributes>?
    
    @Injected private var errorHandler: MErrorHandler!
    
    init(attributes: MLiveActivityAttributes) {
        self.attributes = attributes
    }
    
    func simulate() {
        setupLiveActivity()
        Task {
            try await Task.sleep(nanoseconds: 2_500_000_000)
            await updateActivity(to: .init(trailerState: .preparing))
            try await Task.sleep(nanoseconds: 2_500_000_000)
            await updateActivity(to: .init(trailerState: .playing))
            try await Task.sleep(nanoseconds: 2_500_000_000)
            await updateActivity(to: .init(trailerState: .stopped))
            try await Task.sleep(nanoseconds: 2_500_000_000)
            await liveActivity?.end(
                ActivityContent(state: .init(trailerState: .stopped), staleDate: nil),
                dismissalPolicy: .default
            )
        }
    }
}

private extension MLiveActivityHandler {
    func setupLiveActivity() {
        guard liveActivity == nil else { return }
        
        let initialState = MLiveActivityAttributes.ContentState.init(trailerState: .preparing)
        let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 1.0)
        
        do {
            liveActivity = try Activity.request(attributes: attributes, content: content, pushType: nil)
        } catch {
            errorHandler.process(error)
        }
    }
    
    func updateActivity(to state: MLiveActivityAttributes.ContentState) async {
        await liveActivity?.update(
            ActivityContent<MLiveActivityAttributes.ContentState>(
                state: state,
                staleDate: nil
            ),
            alertConfiguration: nil
        )
    }
}
