//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct UserAPDTO: Content {
    let AP: UUID?
    let date: Date?
    
    func toModel() -> UserAP {
        let model = UserAP()
        
        model.id = UUID()
        model.ap.id = AP
        model.date = date
        
        return model
    }


}


struct UserAPResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let AP: UUID?
    let date: Date?
}
