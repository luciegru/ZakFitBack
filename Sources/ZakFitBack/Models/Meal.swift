//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent

final class Meal: Model, @unchecked Sendable {
    static let schema = "Meal"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Field(key: "type")
    var type: String
    
    @Field(key: "date")
    var date: Date
    
    @Field(key: "totalCal")
    var totalCal: Int

    @Field(key: "totalProt")
    var totalProt: Int

    @Field(key: "totalCarb")
    var totalCarb: Int

    @Field(key: "totalLip")
    var totalLip: Int

    @Siblings(through: MealFood.self, from: \.$meal, to: \.$food)
    var foods: [Food]

    init(){}
    
    func toDTO() -> MealResponseDTO {
        
        return MealResponseDTO(
            
        id: self.id,
        user: self.user.id,
        type: self.type,
        date: self.date,
        totalCal: self.totalCal,
        totalProt: self.totalProt,
        totalCarb: self.totalCarb,
        totalLip: self.totalLip,
        )
    }
    
}
