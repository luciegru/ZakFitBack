//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 27/11/2025.
//

import Fluent
import Vapor


struct MealFoodController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let mealFood = routes.grouped("mealFood")
        let protected = mealFood.grouped(JWTMiddleware())
   
        
        
        protected.get("all", use: getAllFullMealFood)
        protected.get("mealId", ":id", use: getFoodbyMeal)
        protected.post(use: createMealFood)
        protected.delete(":id", use: deleteMealFood)

    }
    
    
    @Sendable
    func getAllFullMealFood(_ req: Request) async throws -> [MealFood]{
        try req.auth.require(UserPayload.self)
        return try await MealFood.query(on: req.db).all()
    }
    

    @Sendable
    func getFoodbyMeal(_ req: Request) async throws -> [FoodResponseDTO] {
        let mealId = req.parameters.get("id", as: UUID.self)

        // Récupérer les pivots
        let pivots = try await MealFood.query(on: req.db)
            .filter(\.$meal.$id == mealId ?? UUID())
            .with(\.$food)
            .all()

        let foods = pivots.map { $0.food }

        return foods.map { $0.toDTO() }
    }
    
    @Sendable
    func createMealFood(_ req: Request) async throws -> MealFoodResponseDTO {

        let payload = try req.auth.require(UserPayload.self)
        let data = try req.content.decode(MealFoodDTO.self)

        guard let mealId = data.meal else {
            throw Abort(.badRequest, reason: "Missing meal ID")
        }

        let mealFood = try data.toModel(mealId: mealId)

        try await mealFood.save(on: req.db)

        return mealFood.toDTO()
    }

    
    
    @Sendable
    func deleteMealFood(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let mealFood = try await MealFood.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await mealFood.delete(on: req.db)
            
        return .noContent
    }
    
}
