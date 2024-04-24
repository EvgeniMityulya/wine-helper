//
//  Wine.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/21/24.
//

import Foundation

struct WineDTO: Codable {
    let id: Int?
    let name: String?
    let isNewArr: Bool?
    let isSpecOffer: Bool?
    let isBestSeller: Bool?
    let yearProduced: Int?
    let price: Double?
    let alcoholPercentage: Double?
    let category: CategoryDTO?
    let prod: ProducerDTO?
    let score: ScoreDTO?
}


struct WineCellDTO: Codable {
    let id: Int?
    let yearProduced: Int?
    let name: String?
    let prod: String?
    let category: CategoryDTO
}

struct CategoryDTO: Codable {
    let id: Int?
    let color: String?
    let sweetness: String?
}

struct ProducerDTO: Codable {
    let id: Int?
    let name: String?
    let details: String?
    let region: RegionDTO?
}

struct RegionDTO: Codable {
    let id: Int?
    let name: String?
    let country: CountryDTO
}

struct CountryDTO: Codable {
    let id: Int?
    let name: String?
}

struct ScoreDTO: Codable {
    let id: Int?
    let sweetness: Int?
    let bitterness: Int?
    let acidity: Int?
    let overall: Double?
}

