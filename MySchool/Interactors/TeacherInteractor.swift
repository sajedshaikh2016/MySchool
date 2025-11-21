//
//  TeacherInteractor.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftData

protocol TeacherInteractorProtocol {
    func fetchTeachers() async throws -> [Teacher]
    func createTeacher(_ teacher: Teacher) async throws
    func updateTeacher(_ teacher: Teacher) async throws
    func deleteTeacher(_ teacher: Teacher) async throws
}

class TeacherInteractor: TeacherInteractorProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchTeachers() async throws -> [Teacher] {
        let descriptor = FetchDescriptor<Teacher>(sortBy: [SortDescriptor(\.user?.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func createTeacher(_ teacher: Teacher) async throws {
        modelContext.insert(teacher)
        try modelContext.save()
    }
    
    func updateTeacher(_ teacher: Teacher) async throws {
        try modelContext.save()
    }
    
    func deleteTeacher(_ teacher: Teacher) async throws {
        modelContext.delete(teacher)
        try modelContext.save()
    }
}
