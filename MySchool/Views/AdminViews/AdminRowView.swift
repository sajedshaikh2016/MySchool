//
//  AdminRowView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI

struct AdminRowView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.headline)
            Text(user.role.rawValue.capitalized)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    AdminRowView()
}
