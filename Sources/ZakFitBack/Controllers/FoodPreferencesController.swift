//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 27/11/2025.
//

import Fluent
import Vapor


struct FoodPreferencesController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let FoodPreferences = routes.grouped("foodPreference")
        
        let protected = FoodPreferences.grouped(JWTMiddleware())
  
        protected.get(use: getAllFoodPreference)
        protected.post(use: createFoodPreference)

        
        protected.group(":id") { FoodPreferences in
            FoodPreferences.delete(use: deleteFoodPreference)
        }
        
    }
    
    @Sendable
    func getAllFoodPreference(_ req: Request) async throws -> [FoodPreferenceResponseDTO] {
        try req.auth.require(UserPayload.self)
        
        let FoodPreferences = try await FoodPreference.query(on: req.db)
            .all()
        
        return FoodPreferences.map{ $0.toDTO()}
    }
    
    @Sendable
    func createFoodPreference(_ req: Request) async throws -> FoodPreferenceResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        let dto = try req.content.decode(CreateFoodPreferenceDTO.self)
        
        let newFoodPreferences = dto.toModel(userId: payload.id)
        
        try await newFoodPreferences.save(on: req.db)
        
        return newFoodPreferences.toDTO()
    }

    

    @Sendable
    func deleteFoodPreference(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let foodPreference = try await FoodPreference.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await foodPreference.delete(on: req.db)
        
        return .noContent

    }
    
    
    
}
