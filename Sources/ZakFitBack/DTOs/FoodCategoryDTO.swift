//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Fluent
import Vapor

struct CreateFoodCategoryDTO: Content {
    var name: String
    
}

struct FoodCategoryResponseDTO: Content {
    var id: UUID?
    var name: String
}
