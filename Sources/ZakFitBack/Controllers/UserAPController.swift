//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 25/11/2025.
//

import Fluent
import Vapor


struct UserAPController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let userAP = routes.grouped("userAP")
        let protected = userAP.grouped(JWTMiddleware())
   
        
        
        protected.get("all", use: getAllFullUserAP)
        protected.get("userId", ":id", use: getAPbyUserId)
        protected.post(use: createUserAP)
        protected.delete(":id", use: deleteUserAP)

    }
    
    
    @Sendable
    func getAllFullUserAP(_ req: Request) async throws -> [UserAP]{
        try req.auth.require(UserPayload.self)
        return try await UserAP.query(on: req.db).all()
    }
    

    @Sendable
    func getAPbyUserId(_ req: Request) async throws -> [APResponseDTO] {
        let userId = req.parameters.get("id", as: UUID.self)

        // Récupérer les pivots
        let pivots = try await UserAP.query(on: req.db)
            .filter(\.$user.$id == userId ?? UUID())
            .with(\.$ap)
            .all()

        let aps = pivots.map { $0.ap }

        return aps.map { $0.toDTO() }
    }
    
    @Sendable
    func createUserAP(_ req: Request) async throws -> UserAPResponseDTO {

        let payload = try req.auth.require(UserPayload.self)

        let data = try req.content.decode(UserAPDTO.self)

        let userAP = UserAP(
            userID: payload.id,
            apID: data.AP ?? UUID(),
            date: Date()
        )

        try await userAP.save(on: req.db)

        return userAP.toDTO()
    }

    
    
    @Sendable
    func deleteUserAP(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let userAP = try await UserAP.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await userAP.delete(on: req.db)
            
        return .noContent
    }
    
}
