//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent
import Vapor

final class UserFoodPreference: Model, @unchecked Sendable, Content{
    static let schema = "UserFoodPreference"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Parent(key: "idFoodPreference")
    var foodPreference: FoodPreference
        
    init(){}
    
    init(userId: UUID, foodPreferenceId: UUID) {
        self.$user.id = userId
        self.$foodPreference.id = foodPreferenceId
    }

    
    func toDTO() -> UserFoodPreferenceResponseDTO {
        UserFoodPreferenceResponseDTO(
            id: self.id,
            user: self.$user.id,
            foodPreference: self.$foodPreference.id
        )
    }

}
