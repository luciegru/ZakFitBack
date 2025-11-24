//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct APObjectiveDTO: Content {
    let user: UUID?
    let APTime: Int?
    let burnedCal: Int?
    let APNumber: Int?
    let startDate: Date
    let endDate: Date
    let intervalDays: Int?
}


struct APObjectiveResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let APTime: Int?
    let burnedCal: Int?
    let APNumber: Int?
    let startDate: Date
    let endDate: Date
    let intervalDays: Int?
}
