//
//  AdminInteractor.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftData

protocol AdminInteractorProtocol {
    func fetchUsers() async throws -> [User]
    func createUser(_ user: User) async throws
    func updateUser(_ user: User) async throws
    func deleteUser(_ user: User) async throws
}

class AdminInteractor: AdminInteractorProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchUsers() async throws -> [User] {
        let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func createUser(_ user: User) async throws {
        modelContext.insert(user)
        try modelContext.save()
    }
    
    func updateUser(_ user: User) async throws {
        try modelContext.save()
    }
    
    func deleteUser(_ user: User) async throws {
        modelContext.delete(user)
        try modelContext.save()
    }
}
