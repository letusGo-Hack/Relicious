//
//  RamenTimerWidget.swift
//  RamenTimerWidget
//
//  Created by 이재웅 on 2023/06/10.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct RamenTimerWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "photo")
                .resizable()
                .clipShape(Circle())
            
            Spacer()
            
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text("불닭볶음면")
                        .font(.system(size: 17, weight: .bold))
                    
                    Text("섭취 수: 999")
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Image(systemName: "play.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct RamenTimerWidget: Widget {
    let kind: String = "RamenTimerWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            RamenTimerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("라면 타이머")
        .description("당신이 라면에게 투표하세요!")
        .supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    RamenTimerWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
