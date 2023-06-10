//
//  RamenTimerWidgetLiveActivity.swift
//  RamenTimerWidget
//
//  Created by 이재웅 on 2023/06/10.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RamenTimerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RamenTimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RamenTimerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RamenTimerWidgetAttributes {
    fileprivate static var preview: RamenTimerWidgetAttributes {
        RamenTimerWidgetAttributes(name: "World")
    }
}

extension RamenTimerWidgetAttributes.ContentState {
    fileprivate static var smiley: RamenTimerWidgetAttributes.ContentState {
        RamenTimerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RamenTimerWidgetAttributes.ContentState {
         RamenTimerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RamenTimerWidgetAttributes.preview) {
   RamenTimerWidgetLiveActivity()
} contentStates: {
    RamenTimerWidgetAttributes.ContentState.smiley
    RamenTimerWidgetAttributes.ContentState.starEyes
}
