//
//  RamenTimerWidget.swift
//  RamenTimerWidget
//
//  Created by 이재웅 on 2023/06/10.
//

import WidgetKit
import SwiftUI

struct RamenTimerWidgetEntryView : View {
    var entry: RamenProvider.Entry

    var body: some View {
        VStack {
            Text("시간:")
            Text("\(entry.ramen.time)")

            Text("라면:")
            Text(entry.ramen.name)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct RamenTimerWidget: Widget {
    let kind: String = "RamenTimerWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: RamenIntent.self, provider: RamenProvider()) { entry in
            RamenTimerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Relicious")
        .description("위젯을 통해 라면타이머를 설정하세요")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    RamenTimerWidget()
} timeline: {
    RamenEntry(ramen: Ramen.getRamen())
}
