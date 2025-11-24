//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 25/11/2025.
//

import Vapor
import Fluent

struct MealDTO: Content {
    let user: UUID?
    let type: String?
    let date: Date?
    let totalCal: Int?
    let totalProt: Int?
    let totalCarb: Int?
    let totalLip: Int?
}


struct MealResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let type: String?
    let date: Date?
    let totalCal: Int?
    let totalProt: Int?
    let totalCarb: Int?
    let totalLip: Int?
}

