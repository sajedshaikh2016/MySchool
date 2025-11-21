//
//  EditStudentView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI

struct EditStudentView: View {
    let student: Student
    @Environment(\.dismiss) private var dismiss
    @State private var presenter: StudentPresenter?
    @State private var name: String
    @State private var email: String
    @State private var grade: String
    @State private var emergencyContact: String
    
    init(student: Student) {
        self.student = student
        _name = State(initialValue: student.user?.name ?? "")
        _email = State(initialValue: student.user?.email ?? "")
        _grade = State(initialValue: student.grade)
        _emergencyContact = State(initialValue: student.emergencyContact)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Grade", text: $grade)
                }
                
                Section("Contact Information") {
                    TextField("Emergency Contact", text: $emergencyContact)
                }
            }
            .navigationTitle("Edit Student")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveChanges()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && !grade.isEmpty && !emergencyContact.isEmpty
    }
    
    private func saveChanges() {
        if let user = student.user {
            user.name = name
            user.email = email
        }
        
        student.grade = grade
        student.emergencyContact = emergencyContact
        
        presenter?.updateStudent(student)
        dismiss()
    }
}

#Preview {
    EditStudentView()
}
