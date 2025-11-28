//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Fluent
import Vapor

struct CreateUserDTO: Content {
    var name: String
    var firstName: String
    var email: String
    var password: String
    var genre: String?
    var picture: String?
    var birthDate: Date?
    var height: Int?
    var weight: Double?
    var healthObjective: String?
    var onboardingDone: Bool = false
    
    func toModel() -> User {
        let model = User()
        
        model.id = UUID()
        model.name = name
        model.firstName = firstName
        model.email = email
        model.password = password
        
        return model
    }

    
}

struct UserResponseDTO: Content {
    var id: UUID
    var name: String
    var firstName: String
    var email: String
    var genre: String?
    var inscriptionDate: Date?
    var picture: String?
    var birthDate: Date?
    var height: Int?
    var weight: Double?
    var healthObjective: String?
    var onboardingDone: Bool
}

struct UpdateUserDTO: Content {
    var name: String?
    var firstName: String?
    var email: String?
    var password: String?
    var genre: String?
    var picture: String?
    var height: Int?
    var weight: Double?
    var healthObjective: String?
    var onboardingDone: Bool?
}
