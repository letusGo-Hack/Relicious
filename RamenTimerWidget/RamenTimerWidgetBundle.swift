//
//  RamenTimerWidgetBundle.swift
//  RamenTimerWidget
//
//  Created by 이재웅 on 2023/06/10.
//

import WidgetKit
import SwiftUI

@main
struct RamenTimerWidgetBundle: WidgetBundle {
    var body: some Widget {
        RamenTimerWidget()
        RamenTimerWidgetLiveActivity()
    }
}
