//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 27/11/2025.
//

import Fluent
import Vapor
import JWT


struct FoodController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let food = routes.grouped("food")
        let protected = food.grouped(JWTMiddleware())
        
        protected.post(use:createFood)
        protected.get("full", use: getAllFullFood)
        
        protected.group(":id"){ food in
            food.delete(use: deleteFood)
            }
        }
        
        // créer une food
        @Sendable
        func createFood(req: Request) async throws -> FoodResponseDTO{
            try req.auth.require(UserPayload.self)
            let food = try req.content.decode(FoodDTO.self).toModel()
            
            
            try await food.save(on: req.db)
            
            
            return food.toDTO()
        }
        
        // récupérer tous les foods
        @Sendable
        func getAllFullFood(_ req: Request) async throws -> [Food]{
            try req.auth.require(UserPayload.self)
            return try await Food.query(on: req.db).all()
        }
        
        //supprimer un food
            @Sendable
            func deleteFood (_ req: Request) async throws -> HTTPStatus{
                try req.auth.require(UserPayload.self)
                guard let food = try await Food.find(req.parameters.get("id"), on: req.db) else {
                    throw Abort(.notFound)
                }
        
                try await food.delete(on: req.db)
                return .noContent
            }
        
    }

