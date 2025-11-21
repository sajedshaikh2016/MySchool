//
//  StudentRowView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI

struct StudentRowView: View {
    let student: Student
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(student.user?.name ?? "Unknown")
                .font(.headline)
            Text("Grade: \(student.grade)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    StudentRowView(student: Student)
}
