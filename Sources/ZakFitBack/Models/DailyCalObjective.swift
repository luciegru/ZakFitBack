//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent


final class DailyCalObjective: Model, @unchecked Sendable {
    static let schema = "DailyCalObjective"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User

    @Field(key: "cal")
    var cal: Int
    
    @Field(key: "prot")
    var prot: Int?
    
    @Field(key: "carb")
    var carb: Int?
    
    @Field(key: "lip")
    var lip: Int?
    
    init(){}
    
    func toDTO() -> DailyCalObjectiveResponseDTO {
        
        return DailyCalObjectiveResponseDTO(
            id: self.id,
            user: self.user.id,
            cal: self.cal,
            prot: self.prot ?? 0,
            carb: self.carb ?? 0,
            lip: self.lip ?? 0
        )
    }
    
}
