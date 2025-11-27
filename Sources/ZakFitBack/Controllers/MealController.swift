//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 27/11/2025.
//

import Fluent
import Vapor


struct MealController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let meal = routes.grouped("meal")
        
        let protected = meal.grouped(JWTMiddleware())
  
        protected.get(use: getAllMeal)
        protected.post(use: createMeal)
        protected.get("user", use: getMyMeals)

        
        protected.group(":id") { mealId in
            mealId.delete(use: deleteMeal)
        }
        
    }
    
    @Sendable
    func getAllMeal(_ req: Request) async throws -> [MealResponseDTO] {
        try req.auth.require(UserPayload.self)
        
        let meal = try await Meal.query(on: req.db)
            .all()
        
        return meal.map{ $0.toDTO()}
    }
    
    @Sendable
    func createMeal(_ req: Request) async throws -> MealResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        let newMeal = try req.content.decode(MealDTO.self).toModel()
        
        newMeal.$user.id = payload.id
        
                
        try await newMeal.save(on: req.db)
        
        return newMeal.toDTO()
    }

    @Sendable
    func getMyMeals(_ req: Request) async throws -> [MealResponseDTO] {
        let payload = try req.auth.require(UserPayload.self)
        
        let meal = try await Meal.query(on: req.db)
            .filter(\.$user.$id == payload.id)
            .sort(\.$date, .descending)
            .all()
            
        return meal.map{ $0.toDTO()}
    }
    

    @Sendable
    func deleteMeal(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let meal = try await Meal.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await meal.delete(on: req.db)
        
        return .noContent

    }
    
    
    
}
