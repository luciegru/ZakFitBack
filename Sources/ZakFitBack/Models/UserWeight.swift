//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent

final class UserWeight: Model, @unchecked Sendable {
    static let schema = "UserWeight"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Field(key: "weight")
    var weight: Double
    
    @Timestamp(key: "date", on: .create)
    var date: Date?
        
    init(){}
    
    func toDTO() -> UserWeightResponseDTO {
        
        return UserWeightResponseDTO(
            
        id: self.id,
        user: self.$user.id,
        weight: self.weight,
        date: self.date
        )
    }
    
}
