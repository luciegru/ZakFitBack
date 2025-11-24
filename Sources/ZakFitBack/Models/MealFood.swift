//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent

final class MealFood: Model, @unchecked Sendable {
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
    
    func toDTO() -> MealFoodResponseDTO {
        
        return MealFoodResponseDTO(
        id: self.id,
        food: self.food.id,
        meal: self.meal.id,
        quantityFood: self.quantityFood
        )
    }
    
}
