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
    let picture: String?
    let alcoholPercentage: Double?
    let categoryId: Int?
    let prodId: Int?
    let scoreId: Int?
}
