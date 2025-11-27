//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 26/11/2025.
//

import Fluent
import Vapor


struct APObjectiveController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let APObj = routes.grouped("APObjective")
        
        let protected = APObj.grouped(JWTMiddleware())
  
        protected.get(use: getAllAPObjective)
        protected.post(use: createAPObjective)
        protected.get("user", use: getMyAPObjective)

        
        protected.group(":id") { APObjectiveId in
            APObjectiveId.patch(use: updateAPObjective)
            APObjectiveId.delete(use: deleteAPObjective)
        }
        
    }
    
    @Sendable
    func getAllAPObjective(_ req: Request) async throws -> [APObjectiveResponseDTO] {
        try req.auth.require(UserPayload.self)
        
        let APObj = try await APObjective.query(on: req.db)
            .all()
        
        return APObj.map{ $0.toDTO()}
    }
    
    @Sendable
    func createAPObjective(_ req: Request) async throws -> APObjectiveResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        let dto = try req.content.decode(APObjectiveDTO.self)
        
        let newAPObj = dto.toModel(userId: payload.id)
        
        try await newAPObj.save(on: req.db)
        
        return newAPObj.toDTO()
    }

    @Sendable
    func getMyAPObjective(_ req: Request) async throws -> APObjectiveResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        if let APObj = try await APObjective.query(on: req.db)
            .filter(\.$user.$id == payload.id)
            .first() {
            
            return APObj.toDTO()
        } else {
            throw Abort(.notFound)
        }
    }
    
    @Sendable
    func updateAPObjective(_ req: Request) async throws -> APObjectiveResponseDTO {
        try req.auth.require(UserPayload.self)
        
        guard let id = req.parameters.get("id", as: UUID.self), let APObj = try await APObjective.query(on: req.db).filter(\.$id == id).first() else {
            throw Abort(.badRequest, reason: "Invalid or missing id")
        }
        
                
        let updatedAPObj = try req.content.decode(APObjectiveDTO.self)
        
        if let APTime = updatedAPObj.APTime {
            APObj.APTime = APTime
        }
        
        if let burned = updatedAPObj.burnedCal {
            APObj.burnedCal = burned
        }
        
        if let APNumber = updatedAPObj.APNumber {
            APObj.APNumber = APNumber
        }
        
        if let start = updatedAPObj.startDate {
            APObj.startDate = start
        }
        
        if let end = updatedAPObj.endDate {
            APObj.endDate = end
        }
        
        if let inter = updatedAPObj.interval {
            APObj.interval = inter
        }
        
        try await APObj.save(on: req.db)
        
        
        return APObj.toDTO()
        
    }



    @Sendable
    func deleteAPObjective(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let APObj = try await APObjective.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await APObj.delete(on: req.db)
        
        return .noContent

    }
    
    
    
}
