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
        VStack(spacing: 0) {
                    Image(systemName: "photo")
                        .resizable()
                        .clipShape(Circle())

                    Spacer()

                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Text(entry.ramen.name)
                                .font(.system(size: 17, weight: .bold))

                            Text("섭취 수: \(entry.ramen.intakeTime)")
                                .font(.system(size: 14))
                        }

                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "play.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
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
