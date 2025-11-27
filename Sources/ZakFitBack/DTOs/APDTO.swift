//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct APDTO: Content {
    let type: String
    let duration: Int
    let intensity: String
    let burnedCal: Int
    let date: Date
    
    func toModel() -> AP {
        let model = AP()
        
        model.id = UUID()
        model.type = type
        model.duration = duration
        model.intensity = intensity
        model.burnedCal = burnedCal
        model.date = date
        
        return model
    }

}


struct APResponseDTO: Content {
    let id: UUID?
    let type: String
    let duration: Int
    let intensity: String
    let burnedCal: Int
    let date: Date
}
