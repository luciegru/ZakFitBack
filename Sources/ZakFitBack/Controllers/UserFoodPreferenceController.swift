//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 27/11/2025.
//

import Fluent
import Vapor


struct UserFoodPreferenceController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let userFoodPreference = routes.grouped("userFoodPreference")
        let protected = userFoodPreference.grouped(JWTMiddleware())
   
        
        
        protected.get("all", use: getAllFullUserFoodPreference)
        protected.get("userId", ":id", use: getUserFoodPreferenceByUserId)
        protected.post(use: createUserFoodPreference)
        protected.delete(":id", use: deleteUserFoodPreference)

    }
    
    
    @Sendable
    func getAllFullUserFoodPreference(_ req: Request) async throws -> [UserFoodPreference]{
        try req.auth.require(UserPayload.self)
        return try await UserFoodPreference.query(on: req.db).all()
    }
    

    @Sendable
    func getUserFoodPreferenceByUserId(_ req: Request) async throws -> [UserFoodPreferenceResponseDTO] {
        let userId = req.parameters.get("id", as: UUID.self)

        // Récupérer les pivots
        let pivots = try await UserFoodPreference.query(on: req.db)
            .filter(\.$user.$id == userId ?? UUID())
            .with(\.$foodPreference)
            .all()

        // Convertir en DTO
        return pivots.map { $0.toDTO() }
    }
    
    @Sendable
    func createUserFoodPreference(_ req: Request) async throws -> UserFoodPreferenceResponseDTO {

        let payload = try req.auth.require(UserPayload.self)

        let data = try req.content.decode(UserFoodPreferenceDTO.self)

        let foodPref = UserFoodPreference(
            userId: payload.id,
            foodPreferenceId: data.foodPreference ?? UUID(),
        )

        try await foodPref.save(on: req.db)

        return foodPref.toDTO()
    }

    
    
    @Sendable
    func deleteUserFoodPreference(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let foodPref = try await UserFoodPreference.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await foodPref.delete(on: req.db)
            
        return .noContent
    }
    
}
