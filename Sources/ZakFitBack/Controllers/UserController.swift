//
//  File.swift
//  ZakFit
//
//  Created by Lucie Grunenberger  on 25/11/2025.
//

import Fluent
import Vapor
import JWT

struct UserController: RouteCollection {
    
    func boot(routes: any RoutesBuilder) throws {
        let user = routes.grouped("user")
        
        
        //routes  public
        user.post(use: self.createUser)
        user.post("login", use: login)
        user.get("all", use: self.getAllUser)
        
        
        //  routes privées
        let protectedRoutes = user.grouped(JWTMiddleware())
        protectedRoutes.delete(":id", use: self.deleteUser)
        protectedRoutes.patch(use: self.updateUser)
        
        //        protectedRoutes.get(use: self.getUserInfo)
        //        protectedRoutes.get(":id", use: getUserById)
        
        
        
    }
    
    @Sendable
    func getAllUser(req: Request) async throws -> [UserResponseDTO] {
        
        let users = try await User.query(on: req.db)
            .all()
        
        
        return users.map { $0.toDTO() }
    }
    
    
    @Sendable
    func createUser(req: Request) async throws -> LoginResponse {
        let user = try req.content.decode(CreateUserDTO.self).toModel()
        
        user.password = try Bcrypt.hash(user.password)
        
        let existing = try await User.query(on: req.db)
            .filter(\.$email == user.email)
            .first()
        
        if existing != nil {
            throw Abort(.badRequest, reason: "Email already taken")
        }
        
        try await user.save(on: req.db)
        
        let payload = UserPayload(id: user.id!)
        let signer = JWTSigner.hs256(key: "ZakFit")
        let token = try signer.sign(payload)
        
        return LoginResponse(token: token, user: user.toDTO())
    }
    
    @Sendable
    func deleteUser(_ req: Request) async throws -> HTTPStatus {
        try req.auth.require(UserPayload.self)
        
        guard let user = try await User.find(req.parameters.get("id", as: UUID.self), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await user.delete(on: req.db)
        
        return .noContent
    }
    
    @Sendable
    func login(req: Request) async throws -> LoginResponse {
        let userData = try req.content.decode(LoginRequest.self)
        
        guard let user = try await User.query(on: req.db)
            .first() else {
            throw Abort(.unauthorized, reason: "Utilisateur inconnu")
        }
        
        guard try Bcrypt.verify(userData.password, created: user.password) else {
            throw Abort(.unauthorized, reason: "Mot de passe incorrect")
        }
        
        let payload = UserPayload(id: user.id!)
        let signer = JWTSigner.hs256(key: "ZakFit")
        let token = try signer.sign(payload)
        
        return LoginResponse(token: token, user: user.toDTO())
    }
    
    
    @Sendable
    func updateUser(_ req: Request) async throws -> UserResponseDTO {
        let payload = try req.auth.require(UserPayload.self)
        
        guard let user = try await User.query(on: req.db).filter(\.$id == payload.id).first() else {
            throw Abort(.notFound, reason: "User not found")
        }
        
        let updatedUser = try req.content.decode(UpdateUserDTO.self)
        
        if let newName = updatedUser.name {
            user.name = newName
        }
        
        if let newFirstName = updatedUser.firstName {
            user.firstName = newFirstName
        }
        
        if let newEmail = updatedUser.email {
            user.email = newEmail
        }
        
        if let newPassword = updatedUser.password {
            user.password = newPassword
        }
        
        if let newGenre = updatedUser.genre {
            user.genre = newGenre
        }
        
        if let newPicture = updatedUser.picture {
            user.picture = newPicture
        }
        
        if let newHeight = updatedUser.height {
            user.height = newHeight
        }
        
        if let newWeight = updatedUser.weight {
            user.weight = newWeight
        }
        
        if let newHealthObjective = updatedUser.healthObjective {
            user.healthObjective = newHealthObjective
        }
        
        
        try await user.save(on: req.db)
        
        return user.toDTO()
    }
    
}
