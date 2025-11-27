//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent

final class User: Model, @unchecked Sendable {
    static let schema = "user"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "genre")
    var genre: String?
    
    @Timestamp(key: "inscriptionDate", on: .create)
    var inscriptionDate: Date?
    
    @Field(key: "picture")
    var picture: String?
    
    @Field(key: "birthDate")
    var birthDate: Date?
    
    @Field(key: "height")
    var height: Int?
    
    @Field(key: "weight")
    var weight: Double?
    
    @Field(key: "healthObjective")
    var healthObjective: String?
    
    @Children(for: \.$user)
    var userWeights: [UserWeight]
    
    @Siblings(through: UserFoodPreference.self, from: \.$user, to: \.$foodPreference)
    var FoodPreferences: [FoodPreference]
    
    @Children(for: \.$user)
    var dailyCalObjectives: [DailyCalObjective]
    
    @Children(for: \.$user)
    var APObjectives: [APObjective]
    
    @Children(for: \.$user)
    var weightObjectives: [WeightObjective]
    
    @Siblings(through: UserAP.self, from: \.$user, to: \.$ap)
    var APs: [AP]
    
    @Children(for: \.$user)
    var meals: [Meal]
    
    init(){}
    
    func toDTO() -> UserResponseDTO {
        
        return UserResponseDTO(
            
        id: self.id ?? UUID(),
        name: self.name,
        firstName: self.firstName,
        email: self.email,
        genre: self.$genre.value ?? "",
        inscriptionDate: self.$inscriptionDate.value ?? Date(),
        picture: self.$picture.value ?? "",
        birthDate: self.$birthDate.value ?? Date(),
        height: self.$height.value ?? 0,
        weight: self.$weight.value ?? 0,
        healthObjective: self.$healthObjective.value ?? ""
        )
    }
    
}
