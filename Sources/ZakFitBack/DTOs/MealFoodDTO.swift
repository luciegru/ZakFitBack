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
    
    func toModel(mealId: UUID) throws -> MealFood {
        let model = MealFood()

        guard let foodId = self.food else {
            throw Abort(.badRequest, reason: "Missing food ID")
        }

        model.id = UUID()
        model.$meal.id = mealId
        model.$food.id = foodId
        model.quantityFood = self.quantityFood

        return model
    }

}


struct MealFoodResponseDTO: Content {
    let id: UUID?
    let food: UUID?
    let meal: UUID?
    let quantityFood: Int
}


