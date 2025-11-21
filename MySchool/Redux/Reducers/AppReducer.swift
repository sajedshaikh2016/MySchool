//
//  AppReducer.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation

typealias AppReducer = Reducer<AppState, AppAction>

let appReducer = AppReducer { state, action in
    switch action {
    case .studentAction(let studentAction):
        studentReducer(&state.studentState, studentAction)
        
    case .teacherAction(let teacherAction):
        teacherReducer(&state.teacherState, teacherAction)
        
    case .adminAction(let adminAction):
        adminReducer(&state.adminState, adminAction)
        
    case .navigationAction(let navigationAction):
        navigationReducer(&state.navigationState, navigationAction)
    }
}

private func studentReducer(_ state: inout StudentState, _ action: StudentAction) {
    switch action {
    case .loadStudents:
        state.isLoading = true
        state.error = nil
        
    case .studentsLoaded(let students):
        state.students = students
        state.isLoading = false
        
    case .selectStudent(let student):
        state.selectedStudent = student
        
    case .addStudent(let student):
        state.students.append(student)
        
    case .updateStudent(let updatedStudent):
        if let index = state.students.firstIndex(where: { $0.id == updatedStudent.id }) {
            state.students[index] = updatedStudent
        }
        
    case .deleteStudent(let student):
        state.students.removeAll { $0.id == student.id }
        
    case .setError(let error):
        state.error = error
        state.isLoading = false
        
    case .setLoading(let loading):
        state.isLoading = loading
    }
}

private func teacherReducer(_ state: inout TeacherState, _ action: TeacherAction) {
    switch action {
    case .loadTeachers:
        state.isLoading = true
        state.error = nil
        
    case .teachersLoaded(let teachers):
        state.teachers = teachers
        state.isLoading = false
        
    case .selectTeacher(let teacher):
        state.selectedTeacher = teacher
        
    case .addTeacher(let teacher):
        state.teachers.append(teacher)
        
    case .updateTeacher(let updatedTeacher):
        if let index = state.teachers.firstIndex(where: { $0.id == updatedTeacher.id }) {
            state.teachers[index] = updatedTeacher
        }
        
    case .deleteTeacher(let teacher):
        state.teachers.removeAll { $0.id == teacher.id }
        
    case .setError(let error):
        state.error = error
        state.isLoading = false
        
    case .setLoading(let loading):
        state.isLoading = loading
    }
}

private func adminReducer(_ state: inout AdminState, _ action: AdminAction) {
    switch action {
    case .loadUsers:
        state.isLoading = true
        state.error = nil
        
    case .usersLoaded(let users):
        state.users = users
        state.isLoading = false
        
    case .selectUser(let user):
        state.selectedUser = user
        
    case .addUser(let user):
        state.users.append(user)
        
    case .updateUser(let updatedUser):
        if let index = state.users.firstIndex(where: { $0.id == updatedUser.id }) {
            state.users[index] = updatedUser
        }
        
    case .deleteUser(let user):
        state.users.removeAll { $0.id == user.id }
        
    case .setError(let error):
        state.error = error
        state.isLoading = false
        
    case .setLoading(let loading):
        state.isLoading = loading
    }
}

private func navigationReducer(_ state: inout NavigationState, _ action: NavigationAction) {
    switch action {
    case .selectTab(let tab):
        state.selectedTab = tab
        
    case .navigateTo(let route):
        state.navigationPath.append(route)
        
    case .goBack:
        if !state.navigationPath.isEmpty {
            state.navigationPath.removeLast()
        }
    }
}
