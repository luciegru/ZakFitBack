//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Foundation
import Fluent


final class APObjective: Model, @unchecked Sendable {
    static let schema = "APObjective"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "idUser")
    var user: User
    
    @Field(key: "APTime")
    var APTime: Int?
    
    @Field(key: "burnedCal")
    var burnedCal: Int?
    
    @Field(key: "APNumber")
    var APNumber: Int?
    
    @Field(key: "startDate")
    var startDate: Date
    
    @Field(key: "endDate")
    var endDate: Date
    
    @Field(key: "intervalDays")
    var intervalDays: Int?
    

    init(){}
    
    func toDTO() -> APObjectiveResponseDTO {
        
        return APObjectiveResponseDTO(
            id: self.id,
            user: self.user.id,
            APTime: self.APTime,
            burnedCal: self.burnedCal,
            APNumber: self.APNumber,
            startDate: self.startDate,
            endDate: self.endDate,
            intervalDays: self.intervalDays

        )
    }
    
}
