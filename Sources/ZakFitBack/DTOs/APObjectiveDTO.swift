//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct APObjectiveDTO: Content {
    let APTime: Int?
    let burnedCal: Int?
    let APNumber: Int?
    let startDate: Date?
    let endDate: Date?
    let interval: Int?
    let step: Int
    let sport: String?
    let timeToAdd: Int?
    
    func toModel(userId: UUID) -> APObjective {
        let model = APObjective()
        
        model.id = UUID()
        model.$user.id = userId 
        model.APTime = APTime
        model.burnedCal = burnedCal
        model.APNumber = APNumber
        model.startDate = startDate
        model.endDate = endDate
        model.interval = interval
        model.step = step
        model.sport = sport
        model.timeToAdd = timeToAdd
        
        return model
    }

}


struct APObjectiveResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let APTime: Int?
    let burnedCal: Int?
    let APNumber: Int?
    let startDate: Date
    let endDate: Date
    let interval: Int?
    let step: Int
    let sport: String?
    let timeToAdd: Int?
    
}
