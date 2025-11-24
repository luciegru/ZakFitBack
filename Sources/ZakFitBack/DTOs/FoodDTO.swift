//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct FoodDTO: Content {
    let foodCategory: UUID?
    let name: String?
    let cal: Int?
    let carb: Int?
    let lip: Int?
    let prot: Int?
    let unit: String?
    let unitWeightG: Double?
}


struct FoodResponseDTO: Content {
    let id: UUID?
    let foodCategory: UUID?
    let name: String?
    let cal: Int?
    let carb: Int?
    let lip: Int?
    let prot: Int?
    let unit: String?
    let unitWeightG: Double?
}

