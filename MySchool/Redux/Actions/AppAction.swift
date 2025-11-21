//
//  AppAction.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation

enum AppAction {
    case studentAction(StudentAction)
    case teacherAction(TeacherAction)
    case adminAction(AdminAction)
    case navigationAction(NavigationAction)
}

enum StudentAction {
    case loadStudents
    case studentsLoaded([Student])
    case selectStudent(Student?)
    case addStudent(Student)
    case updateStudent(Student)
    case deleteStudent(Student)
    case setError(String?)
    case setLoading(Bool)
}

enum TeacherAction {
    case loadTeachers
    case teachersLoaded([Teacher])
    case selectTeacher(Teacher?)
    case addTeacher(Teacher)
    case updateTeacher(Teacher)
    case deleteTeacher(Teacher)
    case setError(String?)
    case setLoading(Bool)
}

enum AdminAction {
    case loadUsers
    case usersLoaded([User])
    case selectUser(User?)
    case addUser(User)
    case updateUser(User)
    case deleteUser(User)
    case setError(String?)
    case setLoading(Bool)
}

enum NavigationAction {
    case selectTab(AppTab)
    case navigateTo(AppRoute)
    case goBack
}
