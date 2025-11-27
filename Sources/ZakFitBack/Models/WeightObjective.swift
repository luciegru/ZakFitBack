//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent


final class WeightObjective: Model, @unchecked Sendable {
    static let schema = "WeightObjective"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Field(key: "targetWeight")
    var targetWeight: Int?
        
    @Field(key: "startDate")
    var startDate: Date?
    
    @Field(key: "endDate")
    var endDate: Date?
        

    init(){}
    
    func toDTO() -> WeightObjectiveResponseDTO {
        
        return WeightObjectiveResponseDTO(
            id: self.id,
            user: self.$user.id,
            targetWeight: self.targetWeight,
            startDate: self.startDate,
            endDate: self.endDate,
        )
    }
    
}
