//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent


final class FoodPreference: Model, @unchecked Sendable {
    static let schema = "FoodPreference"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Siblings(through: UserFoodPreference.self, from: \.$foodPreference, to: \.$user)
    var user: [User]
        
    init(){}
    
    func toDTO() -> FoodPreferenceResponseDTO {
        
        return FoodPreferenceResponseDTO(
            id: self.id,
            name: self.name,
        )
    }
    
}
