//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct WeightObjectiveDTO: Content {
    let user: UUID?
    var targetWeight: Int?
    var startDate: Date?
    var endDate: Date?
    
    func toModel() -> WeightObjective {
        let model = WeightObjective()
        
        model.id = UUID()
        model.$user.id = user ?? UUID()
        model.targetWeight = targetWeight
        model.startDate = startDate
        model.endDate = endDate
        
        return model
    }

}


struct WeightObjectiveResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let targetWeight: Int?
    let startDate: Date?
    let endDate: Date?
}
