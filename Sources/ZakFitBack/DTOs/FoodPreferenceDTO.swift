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
    
    func toModel(userId: UUID) -> FoodPreference {
        let model = FoodPreference()
        
        model.id = UUID()
        model.name = name
        return model
    }

}

struct FoodPreferenceResponseDTO: Content {
    var id: UUID?
    var name: String
}
