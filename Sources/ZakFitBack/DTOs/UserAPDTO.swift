//
//  File.swift
//  ZakFitBack
//
//  Created by Lucie Grunenberger  on 24/11/2025.
//

import Vapor
import Fluent

struct UserAPDTO: Content {
    let user: UUID?
    let AP: UUID?
    let date: Date?
}


struct UserAPResponseDTO: Content {
    let id: UUID?
    let user: UUID?
    let AP: UUID?
    let date: Date?
}
