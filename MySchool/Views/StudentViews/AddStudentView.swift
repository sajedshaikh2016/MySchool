//
//  AddStudentView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI

struct AddStudentView: View {
    @Environment(AppStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var presenter: StudentPresenter?
    @State private var name = ""
    @State private var email = ""
    @State private var grade = ""
    @State private var dateOfBirth = Date()
    @State private var emergencyContact = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                    TextField("Grade", text: $grade)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }
                
                Section("Contact Information") {
                    TextField("Emergency Contact", text: $emergencyContact)
                }
            }
            .navigationTitle("Add Student")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveStudent()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .onAppear {
            setupPresenter()
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && !grade.isEmpty && !emergencyContact.isEmpty
    }
    
    private func saveStudent() {
        let user = User(name: name, email: email, role: .student)
        let student = Student(
            user: user,
            grade: grade,
            enrollmentDate: Date(),
            dateOfBirth: dateOfBirth,
            emergencyContact: emergencyContact
        )
        
        presenter?.addStudent(student)
        dismiss()
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
    AddStudentView()
}
