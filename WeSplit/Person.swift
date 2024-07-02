//
//  Person.swift
//  WeSplit
//
//  Created by Mike Kostenko on 02/07/2024.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String
    var transactions: [HistoricalTransaction]
    
    init(name: String, transactions: [HistoricalTransaction]) {
        self.name = name
        self.transactions = transactions
    }
}
