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
    
    func toModel() -> FoodCategory {
        let model = FoodCategory()
        
        model.id = UUID()
        model.name = self.name
        return model
    }

}

struct FoodCategoryResponseDTO: Content {
    var id: UUID?
    var name: String
}
