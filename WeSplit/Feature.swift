//
//  Feature.swift
//  WeSplit
//
//  Created by Mike Kostenko on 29/10/2024.
//

import Foundation

struct Feature: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let image: String
}
