//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct APPreferenceDTO: Content {
    let type: String
    let duration: Int
    let intensity: String
    let burnedCal: Int
    let date: Date
}


struct APResponseDTO: Content {
    let id: UUID?
    let type: String
    let duration: Int
    let intensity: String
    let burnedCal: Int
    let date: Date
}
