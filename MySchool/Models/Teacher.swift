//
//  Teacher.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftData

@Model
final class Teacher {
    var id: UUID
    var user: User?
    var subject: String
    var hireDate: Date
    var office: String
    
    init(user: User? = nil, subject: String, hireDate: Date, office: String) {
        self.id = UUID()
        self.user = user
        self.subject = subject
        self.hireDate = hireDate
        self.office = office
    }
}
