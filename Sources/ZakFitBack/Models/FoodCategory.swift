//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent


final class FoodCategory: Model, @unchecked Sendable {
    static let schema = "FoodCategory"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Children(for: \.$foodCategory)
    var food: [Food]
        
    init(){}
    
    func toDTO() -> FoodCategoryResponseDTO {
        
        return FoodCategoryResponseDTO(
            id: self.id,
            name: self.name,
        )
    }
    
}
