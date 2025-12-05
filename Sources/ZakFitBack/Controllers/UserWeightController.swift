//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 26/11/2025.
//

import Fluent
import Vapor


struct UserWeightController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let userWeight = routes.grouped("userWeight")
        
        let protected = userWeight.grouped(JWTMiddleware())
  
        protected.get(use: getAlluserWeight)
        protected.post(use: createUserWeight)
        protected.get("user", use: getMyUserWeight)
        protected.post("special", use: createUserWeightWithCustomDate)

        
        protected.group(":id") { userWeight in
            userWeight.delete(use: deleteUserWeight)
            userWeight.patch(use: updateUserWeight)
        }
        
    }
    
    @Sendable
    func createUserWeightWithCustomDate(_ req: Request) async throws -> UserWeightResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        struct SpecialWeightDTO: Content {
            let weight: Double
            let date: String
        }
        
        let data = try req.content.decode(SpecialWeightDTO.self)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let parsedDate = formatter.date(from: data.date) else {
            throw Abort(.badRequest, reason: "Invalid date format. Use yyyy-MM-dd")
        }
        
        let newWeight = UserWeight()
        newWeight.$user.id = payload.id
        newWeight.weight = data.weight
        newWeight.date = parsedDate  // ✅ Date custom
        
        try await newWeight.save(on: req.db)
        
        return newWeight.toDTO()
    }

    
    @Sendable
    func getAlluserWeight(_ req: Request) async throws -> [UserWeightResponseDTO] {
        try req.auth.require(UserPayload.self)
        
        let userWeight = try await UserWeight.query(on: req.db)
            .all()
        
        return userWeight.map{ $0.toDTO()}
    }
    
    @Sendable
    func createUserWeight(_ req: Request) async throws -> UserWeightResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        let newUserWeight = try req.content.decode(CreateUserWeightDTO.self).toModel()
        
        newUserWeight.$user.id = payload.id
        newUserWeight.date = Date()
        
                
        try await newUserWeight.save(on: req.db)
        
        return newUserWeight.toDTO()
        
    }
    
    @Sendable
    func getMyUserWeight(_ req: Request) async throws -> [UserWeightResponseDTO] {
        let payload = try req.auth.require(UserPayload.self)
        
        let allWeights = try await UserWeight.query(on: req.db)
            .filter(\.$user.$id == payload.id)
            .sort(\.$date, .descending)
            .all()
        
        return allWeights.map { $0.toDTO() }
    }

    @Sendable
    func updateUserWeight(_ req: Request) async throws -> UserWeightResponseDTO {
        try req.auth.require(UserPayload.self)
        
        guard let id = req.parameters.get("id", as: UUID.self), let userWeight = try await UserWeight.query(on: req.db).filter(\.$id == id).first() else {
            throw Abort(.badRequest, reason: "Invalid or missing id")
        }
        
                
        let updatedUserWeight = try req.content.decode(UserWeightResponseDTO.self)
        
        if let weight = updatedUserWeight.weight {
            userWeight.weight = weight
        }
        
        userWeight.date = Date.now
        try await userWeight.save(on: req.db)
        
        
        return userWeight.toDTO()
        
    }



    @Sendable
    func deleteUserWeight(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let userWeight = try await UserWeight.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await userWeight.delete(on: req.db)
        
        return .noContent

    }
    
    
    
}
