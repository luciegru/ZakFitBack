//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Fluent
import Vapor

struct CreateFoodPreferenceDTO: Content {
    var name: String
    
}

struct FoodPreferenceResponseDTO: Content {
    var id: UUID?
    var name: String
}
