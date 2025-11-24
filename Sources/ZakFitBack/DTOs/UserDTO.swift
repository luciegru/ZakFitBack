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
    
}

struct UserResponseDTO: Content {
    var id: UUID?
    var name: String
    var firstName: String
    var email: String
    var password: String
    var genre: String?
    var inscriptionDate: Date?
    var picture: String?
    var birthDate: Date?
    var height: Int?
    var weight: Double?
    var healthObjective: String?
}
