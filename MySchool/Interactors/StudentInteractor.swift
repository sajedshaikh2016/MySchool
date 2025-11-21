//
//  StudentInteractor.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftData

protocol StudentInteractorProtocol {
    func fetchStudents() async throws -> [Student]
    func createStudent(_ student: Student) async throws
    func updateStudent(_ student: Student) async throws
    func deleteStudent(_ student: Student) async throws
}

class StudentInteractor: StudentInteractorProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchStudents() async throws -> [Student] {
        let descriptor = FetchDescriptor<Student>(sortBy: [SortDescriptor(\.user?.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func createStudent(_ student: Student) async throws {
        modelContext.insert(student)
        try modelContext.save()
    }
    
    func updateStudent(_ student: Student) async throws {
        try modelContext.save()
    }
    
    func deleteStudent(_ student: Student) async throws {
        modelContext.delete(student)
        try modelContext.save()
    }
}
