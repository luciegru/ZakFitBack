//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct WeightObjectiveDTO: Content {
    let user: UUID?
    let targetWeight: Int?
    let startDate: Date?
    let endDate: Date?
}


struct WeightObjectiveResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let targetWeight: Int?
    let startDate: Date?
    let endDate: Date?
}
