//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 27/11/2025.
//

import Fluent
import Vapor
import JWT


struct FoodCategoryController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let foodCat = routes.grouped("foodCategory")
        let protected = foodCat.grouped(JWTMiddleware())
        
        protected.post(use:createFoodCategory)
        protected.get("full", use: getAllFullFoodCategory)
        
        protected.group(":id"){ foodCat in
            foodCat.delete(use: deleteFoodCategory)
            }
        }
        
        // créer une AP
        @Sendable
        func createFoodCategory(req: Request) async throws -> FoodCategoryResponseDTO{
            try req.auth.require(UserPayload.self)
            let foodCat = try req.content.decode(CreateFoodCategoryDTO.self).toModel()
            
            
            try await foodCat.save(on: req.db)
            
            
            return foodCat.toDTO()
        }
        
        // récupérer toutes les Activités Physiques (AP)
        @Sendable
        func getAllFullFoodCategory(_ req: Request) async throws -> [FoodCategory]{
            try req.auth.require(UserPayload.self)
            return try await FoodCategory.query(on: req.db).all()
        }
        
        //supprimer une FoodCategory
            @Sendable
            func deleteFoodCategory(_ req: Request) async throws -> HTTPStatus{
                try req.auth.require(UserPayload.self)
                guard let foodCat = try await FoodCategory.find(req.parameters.get("id"), on: req.db) else {
                    throw Abort(.notFound)
                }
        
                try await foodCat.delete(on: req.db)
                return .noContent
            }
        
    }

