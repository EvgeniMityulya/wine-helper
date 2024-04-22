//
//  Wine.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/21/24.
//

import Foundation

struct Wine: Decodable {
    let brand: String
    let name: String
    let category: String
    let description: String
    let alcoholPl: Float
    let rating: Float
    let sweetness: Int
    let bitterness: Int
    let acidity: Int
    let country: String
    let region: String
    let grapeVarieties: [String]
    let harvestDate: Int
    let recommendations: String
    let price: Float
}

struct WineDTO: Codable {
    let id: Int?
    let name: String?
    let yearProduced: Int?
    let alcoholPercentage: Double?
    let category: Category
    let prod: Prod
    let score: Score
}

struct Category: Codable {
    let id: Int?
    let name: String?
}

struct Prod: Codable {
    let id: Int?
    let name: String?
    let details: String?
    let regionId: Int?
}

struct Score: Codable {
    let id: Int?
    let sweetness: Int?
    let bitterness: Int?
    let acidity: Int?
    let overall: Int?
    let wineId: Int?
}

