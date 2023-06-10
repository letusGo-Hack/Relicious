//
//  AppIntent.swift
//  RamenTimerWidget
//
//  Created by 이재웅 on 2023/06/10.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
    
    
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
