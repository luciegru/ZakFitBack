//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 25/11/2025.
//

import Vapor
import Fluent

struct MealDTO: Content {
    let user: UUID?
    let type: String?
    let date: Date?
    let totalCal: Int?
    let totalProt: Int?
    let totalCarb: Int?
    let totalLip: Int?
    
    func toModel() -> Meal {
        let model = Meal()
        
        model.id = UUID()
        model.type = type ?? "snack"
        model.date = date ?? Date.now
        model.totalCal = totalCal ?? 0
        model.totalProt = totalProt ?? 0
        model.totalCarb = totalCarb ?? 0
        model.totalLip = totalLip ?? 0
        return model
    }

}


struct MealResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let type: String?
    let date: Date?
    let totalCal: Int?
    let totalProt: Int?
    let totalCarb: Int?
    let totalLip: Int?
}

