//
//  AppState.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation

struct AppState {
    var studentState: StudentState
    var teacherState: TeacherState
    var adminState: AdminState
    var navigationState: NavigationState
    
    static var initial: AppState {
        AppState(
            studentState: StudentState(),
            teacherState: TeacherState(),
            adminState: AdminState(),
            navigationState: NavigationState()
        )
    }
}

struct StudentState {
    var students: [Student] = []
    var selectedStudent: Student?
    var isLoading: Bool = false
    var error: String?
}

struct TeacherState {
    var teachers: [Teacher] = []
    var selectedTeacher: Teacher?
    var isLoading: Bool = false
    var error: String?
}

struct AdminState {
    var users: [User] = []
    var selectedUser: User?
    var isLoading: Bool = false
    var error: String?
}

struct NavigationState {
    var selectedTab: AppTab = .students
    var navigationPath: [AppRoute] = []
}

enum AppTab {
    case students, teachers, admins
}

enum AppRoute: Hashable {
    case studentDetail(Student)
    case teacherDetail(Teacher)
    case adminDetail(User)
    case addStudent
    case addTeacher
    case addAdmin
}
