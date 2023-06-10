//
//  RamenEntry.swift
//  Relicious
//
//  Created by 이재웅 on 2023/06/10.
//

import WidgetKit
import Foundation

struct RamenEntry: TimelineEntry {
    let date = Date()
    let ramen: Ramen
}

struct Ramen {
    let name: String
    let intakeTime: Int
    
    static func getRamen() -> Ramen {
        
        return Ramen(name: "진라면", intakeTime: 0)
    }
}
