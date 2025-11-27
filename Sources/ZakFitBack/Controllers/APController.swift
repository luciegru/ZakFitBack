//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 25/11/2025.
//

import Fluent
import Vapor
import JWT


struct APController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let APs = routes.grouped("AP")
        let protected = APs.grouped(JWTMiddleware())
        
        protected.post(use:createAP)
        protected.get("full", use: getAllFullAP)
        
        protected.group(":id"){ AP in
            AP.get(use: getAPById)
            AP.delete(use: deleteAP)
            }
        }
        
        // créer une AP
        @Sendable
        func createAP(req: Request) async throws -> APResponseDTO{
            try req.auth.require(UserPayload.self)
            let AP = try req.content.decode(APDTO.self).toModel()
            
            
            try await AP.save(on: req.db)
            
            
            return AP.toDTO()
        }
        
        // récupérer toutes les Activités Physiques (AP)
        @Sendable
        func getAllFullAP(_ req: Request) async throws -> [AP]{
            try req.auth.require(UserPayload.self)
            return try await AP.query(on: req.db).all()
        }
        
        //récupérer une AP par son id
        @Sendable
        func getAPById(_ req: Request) async throws -> APResponseDTO{
            try req.auth.require(UserPayload.self)
            guard let AP = try await AP.find(req.parameters.get("id"), on: req.db) else {
                throw Abort(.notFound)
            }
            
            return AP.toDTO()
        }

        //supprimer un personnage
            @Sendable
            func deleteAP(_ req: Request) async throws -> HTTPStatus{
                try req.auth.require(UserPayload.self)
                guard let AP = try await AP.find(req.parameters.get("id"), on: req.db) else {
                    throw Abort(.notFound)
                }
        
                try await AP.delete(on: req.db)
                return .noContent
            }
        
    }

