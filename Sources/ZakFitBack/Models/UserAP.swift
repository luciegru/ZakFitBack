//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent

final class UserAP: Model, @unchecked Sendable {
    static let schema = "UserAP"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Parent(key: "idAP")
    var ap: AP
    
    @Field(key: "date")
    var date: Date?
    
        
    init(){}
    
    func toDTO() -> UserAPResponseDTO {
        
        return UserAPResponseDTO(
        id: self.id,
        user: self.user.id,
        AP: self.ap.id,
        date: self.date
        
        )
    }
    
}
