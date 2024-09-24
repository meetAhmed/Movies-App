//
//  MWidgetLiveActivity.swift
//  MWidget
//
//  Created by Ahmed Ali on 23/09/2024.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct MLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MLiveActivityAttributes.self) { context in
            MLiveActivityLockView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    MLiveActivityLeading(context: context)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    MLiveActivityTrailing()
                        .vAlign(.center)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    MLiveActivityBottom(context: context)
                }
            } compactLeading: {
                MLiveActivityCompactLeading(context: context)
            } compactTrailing: {
                MLiveActivityTrailing()
            } minimal: {
                MLiveActivityMinimal()
            }
        }
    }
}

extension MLiveActivityAttributes {
    fileprivate static var preview: MLiveActivityAttributes {
        MLiveActivityAttributes(movieTitle: "The Crow")
    }
}

#Preview("Notification", as: .content, using: MLiveActivityAttributes.preview) {
    MLiveActivityWidget()
} contentStates: {
    MLiveActivityAttributes.ContentState(trailerState: .playing)
}
