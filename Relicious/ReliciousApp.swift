//
//  ReliciousApp.swift
//  Relicious
//
//  Created by Milkyo on 6/10/23.
//

import SwiftUI

@main
struct ReliciousApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(ramyun: Ramyun(name: "진라면", time: 100))
        }
    }
}
