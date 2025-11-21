//
//  TeacherRowView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI

struct TeacherRowView: View {
    let teacher: Teacher
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(teacher.user?.name ?? "Unknown")
                .font(.headline)
            Text(teacher.subject)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    TeacherRowView(teacher: Teacher)
}
