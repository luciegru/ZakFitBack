//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent
import Vapor

final class Food: Model, @unchecked Sendable, Content {
    static let schema = "Food"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idFoodCategory")
    var foodCategory: FoodCategory
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "cal")
    var cal: Int
    
    @Field(key: "carb")
    var carb: Int

    @Field(key: "lip")
    var lip: Int

    @Field(key: "prot")
    var prot: Int

    @Field(key: "unit")
    var unit: String

    @Field(key: "unit_weight_g")
    var unitWeightG: Double?
    
    @Siblings(through: MealFood.self, from: \.$food, to: \.$meal)
    var meals: [Meal]

    init(){}
    
    func toDTO() -> FoodResponseDTO {
        
        return FoodResponseDTO(
            
        id: self.id,
        foodCategory: self.$foodCategory.id,
        name: self.name,
        cal: self.cal,
        carb: self.carb,
        lip: self.lip,
        prot: self.prot,
        unit: self.unit,
        unitWeightG: self.unitWeightG
        )
    }
    
}
