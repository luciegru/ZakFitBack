//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent

final class UserFoodPreference: Model, @unchecked Sendable {
    static let schema = "UserFoodPreference"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Parent(key: "idFoodPreference")
    var foodPreference: FoodPreference
        
    init(){}
    
    func toDTO() -> UserFoodPreferenceResponseDTO {
        
        return UserFoodPreferenceResponseDTO(
        id: self.id,
        user: self.user.id,
        foodPreference: self.foodPreference.id
        )
    }
    
}
