//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent
import Vapor

final class UserAP: Model, @unchecked Sendable, Content {
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
    init(id: UUID? = nil, userID: UUID, apID: UUID, date: Date = Date()) {
        self.id = id
        self.$user.id = userID
        self.$ap.id = apID
        self.date = date
    }

    
    func toDTO() -> UserAPResponseDTO {
        return UserAPResponseDTO(
            id: self.id!,
            user: self.$user.id,
            AP: self.$ap.id,
            date: self.date
        )
    }

}
