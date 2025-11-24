//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct DailyCalObjectiveDTO: Content {
    let user: UUID?
    let cal: Int
    let prot: Int
    let carb: Int
    let lip: Int
}


struct DailyCalObjectiveResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let cal: Int
    let prot: Int
    let carb: Int
    let lip: Int
}
