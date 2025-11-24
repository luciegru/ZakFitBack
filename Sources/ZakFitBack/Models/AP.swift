//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent


final class AP: Model, @unchecked Sendable {
    static let schema = "AP"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "type")
    var type: String
    
    @Field(key: "duration")
    var duration: Int
    
    @Field(key: "intensity")
    var intensity: String
    
    @Field(key: "burnedCal")
    var burnedCal: Int
    
    @Field(key: "date")
    var date: Date
    
    @Siblings(through: UserAP.self, from: \.$ap, to: \.$user)
    var user: [User]
        
    init(){}
    
    func toDTO() -> APResponseDTO {
        
        return APResponseDTO(
            id: self.id,
            type: self.type,
            duration: self.duration,
            intensity: self.intensity,
            burnedCal: self.burnedCal,
            date: self.date
        )
    }
    
}
