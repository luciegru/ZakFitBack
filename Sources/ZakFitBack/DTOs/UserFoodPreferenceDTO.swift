//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct UserFoodPreferenceDTO: Content {
    let user: UUID?
    let foodPreference: UUID?
}


struct UserFoodPreferenceResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let foodPreference: UUID?
}
