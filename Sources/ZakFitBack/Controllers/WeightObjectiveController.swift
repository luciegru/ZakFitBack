//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 26/11/2025.
//

import Fluent
import Vapor


struct WeightObjectiveController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let weightObj = routes.grouped("weightObjective")
        
        let protected = weightObj.grouped(JWTMiddleware())
  
        protected.get(use: getAllWeightObjective)
        protected.post(use: createWeightObjective)
        protected.get("user", use: getMyWeightObjective)

        
        protected.group(":id") { weightObjectiveId in
            weightObjectiveId.patch(use: updateWeightObjective)
            weightObjectiveId.delete(use: deleteWeightObjective)
        }
        
    }
    
    @Sendable
    func getAllWeightObjective(_ req: Request) async throws -> [WeightObjectiveResponseDTO] {
        try req.auth.require(UserPayload.self)
        
        let weightObj = try await WeightObjective.query(on: req.db)
            .all()
        
        return weightObj.map{ $0.toDTO()}
    }
    
    @Sendable
    func createWeightObjective(_ req: Request) async throws -> WeightObjectiveResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        let newWeightObj = try req.content.decode(WeightObjectiveDTO.self).toModel()
        
        newWeightObj.$user.id = payload.id
        
        if let oldWeightObj = try await WeightObjective.query(on: req.db)
            .filter(\.$user.$id == payload.id)
            .first() {
            try await oldWeightObj.delete(on: req.db)
        }

        
                
        try await newWeightObj.save(on: req.db)
        
        return newWeightObj.toDTO()
        
    }
    
    @Sendable
    func getMyWeightObjective(_ req: Request) async throws -> WeightObjectiveResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        if let weightObj = try await WeightObjective.query(on: req.db)
            .filter(\.$user.$id == payload.id)
            .first() {
            
            return weightObj.toDTO()
        } else {
            throw Abort(.notFound)
        }
    }
    
    @Sendable
    func updateWeightObjective(_ req: Request) async throws -> WeightObjectiveResponseDTO {
        try req.auth.require(UserPayload.self)
        
        guard let id = req.parameters.get("id", as: UUID.self), let weightObj = try await WeightObjective.query(on: req.db).filter(\.$id == id).first() else {
            throw Abort(.badRequest, reason: "Invalid or missing id")
        }
        
                
        let updatedWeightObj = try req.content.decode(WeightObjectiveDTO.self)
        
        if let target = updatedWeightObj.targetWeight {
            weightObj.targetWeight = target
        }
        
        if let start = updatedWeightObj.startDate {
            weightObj.startDate = start
        }
        
        if let end = updatedWeightObj.endDate {
            weightObj.endDate = end
        }
        
        try await weightObj.save(on: req.db)
        
        
        return weightObj.toDTO()
        
    }



    @Sendable
    func deleteWeightObjective(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let weightObj = try await WeightObjective.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await weightObj.delete(on: req.db)
        
        return .noContent

    }
    
    
    
}
