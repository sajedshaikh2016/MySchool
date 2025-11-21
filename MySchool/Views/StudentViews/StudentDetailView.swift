//
//  StudentDetailView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI

struct StudentDetailView: View {
    let student: Student
    @Environment(AppStore.self) private var store
    @State private var presenter: StudentPresenter?
    @State private var showingEditSheet = false
    
    var body: some View {
        Form {
            Section("Personal Information") {
                LabeledContent("Name", value: student.user?.name ?? "Unknown")
                LabeledContent("Email", value: student.user?.email ?? "Unknown")
                LabeledContent("Grade", value: student.grade)
                LabeledContent("Date of Birth", value: student.dateOfBirth, format: .dateTime.day().month().year())
            }
            
            Section("Enrollment") {
                LabeledContent("Enrollment Date", value: student.enrollmentDate, format: .dateTime.day().month().year())
                LabeledContent("Emergency Contact", value: student.emergencyContact)
            }
        }
        .navigationTitle("Student Details")
        .toolbar {
            Button("Edit") {
                showingEditSheet = true
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditStudentView(student: student)
        }
        .onAppear {
            setupPresenter()
        }
    }
    
    private func setupPresenter() {
        let modelContext = ModelContext(store.modelContainer)
        let interactor = StudentInteractor(modelContext: modelContext)
        let studentStore = store.derived(
            deriveState: \.studentState,
            embedAction: AppAction.studentAction
        )
        presenter = StudentPresenter(interactor: interactor, store: studentStore)
    }
}

#Preview {
    StudentDetailView(student: Student)
}
