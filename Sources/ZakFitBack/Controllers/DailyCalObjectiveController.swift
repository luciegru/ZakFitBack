//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 26/11/2025.
//

import Fluent
import Vapor


struct DailyCalObjectiveController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let DailyCalObj = routes.grouped("DailyCalObjective")
        
        let protected = DailyCalObj.grouped(JWTMiddleware())
  
        protected.get(use: getAllDailyCalObjective)
        protected.post(use: createDailyCalObjective)
        protected.get("user", use: getMyDailyCalObjective)

        
        protected.group(":id") { DailyCalObjectiveId in
            DailyCalObjectiveId.patch(use: updateDailyCalObjective)
            DailyCalObjectiveId.delete(use: deleteDailyCalObjective)
        }
        
    }
    
    @Sendable
    func getAllDailyCalObjective(_ req: Request) async throws -> [DailyCalObjectiveResponseDTO] {
        try req.auth.require(UserPayload.self)
        
        let DailyCalObj = try await DailyCalObjective.query(on: req.db)
            .all()
        
        return DailyCalObj.map{ $0.toDTO()}
    }
    
    @Sendable
    func createDailyCalObjective(_ req: Request) async throws -> DailyCalObjectiveResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        let dto = try req.content.decode(DailyCalObjectiveDTO.self)
        
        let newDailyCalObj = dto.toModel(userId: payload.id)
        
        try await newDailyCalObj.save(on: req.db)
        
        return newDailyCalObj.toDTO()
    }

    @Sendable
    func getMyDailyCalObjective(_ req: Request) async throws -> DailyCalObjectiveResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        if let DailyCalObj = try await DailyCalObjective.query(on: req.db)
            .filter(\.$user.$id == payload.id)
            .first() {
            
            return DailyCalObj.toDTO()
        } else {
            throw Abort(.notFound)
        }
    }
    
    @Sendable
    func updateDailyCalObjective(_ req: Request) async throws -> DailyCalObjectiveResponseDTO {
        try req.auth.require(UserPayload.self)
        
        guard let id = req.parameters.get("id", as: UUID.self), let DailyCalObj = try await DailyCalObjective.query(on: req.db).filter(\.$id == id).first() else {
            throw Abort(.badRequest, reason: "Invalid or missing id")
        }
        
                
        let updatedDailyCalObj = try req.content.decode(DailyCalObjectiveDTO.self)
        
        if let cal = updatedDailyCalObj.cal {
            DailyCalObj.cal = cal
        }
        
        if let prot = updatedDailyCalObj.prot {
            DailyCalObj.prot = prot
        }
        
        if let carb = updatedDailyCalObj.carb {
            DailyCalObj.carb = carb
        }
        
        if let lip = updatedDailyCalObj.lip {
            DailyCalObj.lip = lip
        }
        
        try await DailyCalObj.save(on: req.db)
        
        
        return DailyCalObj.toDTO()
        
    }



    @Sendable
    func deleteDailyCalObjective(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let DailyCalObj = try await DailyCalObjective.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await DailyCalObj.delete(on: req.db)
        
        return .noContent

    }
    
    
    
}
