//
//  RamenProvider.swift
//  Relicious
//
//  Created by 이재웅 on 2023/06/10.
//

import AppIntents
import WidgetKit
import Foundation

struct RamenProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> RamenEntry {
        RamenEntry(ramen: Ramen.getRamen())
    }
    
    typealias Intent = RamenIntent
    typealias Entry = RamenEntry
    
    func getSnapshot(for configuration: RamenIntent, in context: Context, completion: @escaping (RamenEntry) -> Void) {
        let entry = Entry(ramen: Ramen.getRamen())
        
        completion(entry)
    }
    
    func getTimeline(for configuration: RamenIntent, in context: Context, completion: @escaping (Timeline<RamenEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        
        // 이곳에서 데이터를 fetch해 데이터를 전달함.
        let entry = Entry(ramen: Ramen.getRamen())
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }

}

struct LogDrinkIntent: AppIntent {
    init() {} //
    
    static var title: LocalizedStringResource = "Log a drink"
    static var description = IntentDescription("Log a drink and its caffeine amount.")

    
    var rame: Ramen = .init(name: "", intakeTime: 0)

    init(rame: Ramen) {
        self.rame = rame
    }

    func perform() async throws -> some IntentResult {
        Swift.print("## Called")
//        await DrinksLogStore.shared.log(drink: drink)
        return .result()
    }
}
