//
//  Student.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftData

@Model
final class Student {
    var id: UUID
    var user: User?
    var grade: String
    var enrollmentDate: Date
    var dateOfBirth: Date
    var emergencyContact: String
    
    init(user: User? = nil, grade: String, enrollmentDate: Date, dateOfBirth: Date, emergencyContact: String) {
        self.id = UUID()
        self.user = user
        self.grade = grade
        self.enrollmentDate = enrollmentDate
        self.dateOfBirth = dateOfBirth
        self.emergencyContact = emergencyContact
    }
}
