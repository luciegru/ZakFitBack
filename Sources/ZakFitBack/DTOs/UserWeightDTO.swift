//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Fluent
import Vapor

struct CreateUserWeightDTO: Content {
    var weight: Double
    
}

struct UserWeightResponseDTO: Content {
    var id: UUID?
    var user: UUID?
    var weight: Double
    var date: Date?
}
