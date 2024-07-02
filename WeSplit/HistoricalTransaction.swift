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
    @Relationship(inverse: \Person.transactions) var contacts: [Person]
    
    init(date: Date = .now, contacts: [Person], people: Int, checkAmount: Double, tipsPercentage: Int, comment: String = "") {
        self.date = date
        self.contacts = contacts
        self.people = people
        self.checkAmount = checkAmount
        self.tipsPercentage = tipsPercentage
        self.comment = comment
    }
}
