//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent
import Vapor

final class MealFood: Model, @unchecked Sendable, Content {
    static let schema = "MealFood"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idFood")
    var food: Food
    
    @Parent(key: "idMeal")
    var meal: Meal
        
    @Field(key: "quantityFood")
    var quantityFood: Int
    
    
    init(){}
    
    init(id: UUID? = nil, mealID: UUID, foodID: UUID, quantity: Int) {
        self.id = id
        self.$meal.id = mealID
        self.$food.id = foodID
        self.quantityFood = quantity
    }

    
    func toDTO() -> MealFoodResponseDTO {
        
        return MealFoodResponseDTO(
        id: self.id,
        food: self.$food.id,
        meal: self.$meal.id,
        quantityFood: self.quantityFood
        )
    }
    
}
