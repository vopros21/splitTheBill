//
//  HistoricalTransaction.swift
//  WeSplit
//
//  Created by Mike Kostenko on 23/06/2024.
//

import Foundation
import SwiftData

@Model
class HistoricalTransaction {
    var date: Date
    var people: Int
    var checkAmount: Double
    var tipsPercentage: Int
    var comment: String
    
    init(date: Date = .now, people: Int, checkAmount: Double, tipsPercentage: Int, comment: String = "") {
        self.date = date
        self.people = people
        self.checkAmount = checkAmount
        self.tipsPercentage = tipsPercentage
        self.comment = comment
    }
}
