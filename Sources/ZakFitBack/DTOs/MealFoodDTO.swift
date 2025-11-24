//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 25/11/2025.
//

import Vapor
import Fluent

struct MealFoodDTO: Content {
    let food: UUID?
    let meal: UUID?
    let quantityFood: Int
}


struct MealFoodResponseDTO: Content {
    let id: UUID?
    let food: UUID?
    let meal: UUID?
    let quantityFood: Int
}


