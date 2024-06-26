//
//  WeSplitApp.swift
//  WeSplit
//
//  Created by Mike Kostenko on 20/08/2023.
//

import SwiftData
import SwiftUI

@main
struct WeSplitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: HistoricalTransaction.self)
    }
}
