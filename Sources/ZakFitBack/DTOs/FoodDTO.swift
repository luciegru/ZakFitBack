//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct FoodDTO: Content {
    let foodCategory: UUID?
    let name: String?
    let cal: Int?
    let carb: Int?
    let lip: Int?
    let prot: Int?
    let unit: String?
    let unitWeightG: Double?
    
    func toModel() -> Food {
        let model = Food()
        
        model.id = UUID()
        model.$foodCategory.id = foodCategory ?? UUID()
        model.name = name ?? ""
        model.cal = cal ?? 0
        model.carb = carb ?? 0
        model.lip = lip ?? 0
        model.prot = prot ?? 0
        model.unit = unit ?? ""
        model.unitWeightG = unitWeightG
        
        return model
    }

}


struct FoodResponseDTO: Content {
    let id: UUID?
    let foodCategory: UUID?
    let name: String?
    let cal: Int?
    let carb: Int?
    let lip: Int?
    let prot: Int?
    let unit: String?
    let unitWeightG: Double?
}

