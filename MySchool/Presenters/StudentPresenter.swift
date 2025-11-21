//
//  StudentPresenter.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import Combine

class StudentPresenter: ObservableObject {
    @Published var students: [Student] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let interactor: StudentInteractorProtocol
    private let store: Store<StudentState, StudentAction>
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: StudentInteractorProtocol, store: Store<StudentState, StudentAction>) {
        self.interactor = interactor
        self.store = store
        
        store.$state
            .map(\.students)
            .assign(to: &$students)
        
        store.$state
            .map(\.isLoading)
            .assign(to: &$isLoading)
        
        store.$state
            .map(\.error)
            .assign(to: &$error)
    }
    
    func loadStudents() {
        store.send(.setLoading(true))
        Task {
            do {
                let students = try await interactor.fetchStudents()
                await MainActor.run {
                    store.send(.studentsLoaded(students))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func addStudent(_ student: Student) {
        Task {
            do {
                try await interactor.createStudent(student)
                await MainActor.run {
                    store.send(.addStudent(student))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func updateStudent(_ student: Student) {
        Task {
            do {
                try await interactor.updateStudent(student)
                await MainActor.run {
                    store.send(.updateStudent(student))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func deleteStudent(_ student: Student) {
        Task {
            do {
                try await interactor.deleteStudent(student)
                await MainActor.run {
                    store.send(.deleteStudent(student))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func selectStudent(_ student: Student?) {
        store.send(.selectStudent(student))
    }
}
