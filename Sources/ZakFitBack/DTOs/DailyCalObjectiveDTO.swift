//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct DailyCalObjectiveDTO: Content {
    let user: UUID?
    let cal: Int?
    let prot: Int?
    let carb: Int?
    let lip: Int?
    
    func toModel(userId: UUID) -> DailyCalObjective {
        let model = DailyCalObjective()
        
        model.id = UUID()
        model.$user.id = userId
        model.cal = cal ?? 0
        model.prot = prot
        model.carb = carb
        model.lip = lip
        return model
    }

    
}


struct DailyCalObjectiveResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let cal: Int
    let prot: Int
    let carb: Int
    let lip: Int
}
