//
//  StartTimerIntent.swift
//  Relicious
//
//  Created by 이재웅 on 2023/06/10.
//
import SwiftUI
import AppIntents

struct StartTimerIntent: AppIntent {
    static var title: LocalizedStringResource = "Start a Ramen Timer"
    
    
    func perform() async throws -> some IntentResult {
        
        return .result()
    }
}

extension Button {
    init<I: AppIntent>(
        intent: I,
        @ViewBuilder label: () -> Label
    )
}
