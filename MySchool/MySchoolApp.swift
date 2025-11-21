//
//  MySchoolApp.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI
import SwiftData

@main
struct MySchoolApp: App {
    let store: AppStore
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: User.self, Student.self, Teacher.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
        
        self.store = AppStore(
            initialState: .initial,
            reducer: appReducer
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .environment(store)
        }
    }
}
