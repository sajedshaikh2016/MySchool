//
//  User.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: UUID
    var name: String
    var email: String
    var role: UserRole
    var createdAt: Date
    
    init(name: String, email: String, role: UserRole) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.role = role
        self.createdAt = Date()
    }
}

