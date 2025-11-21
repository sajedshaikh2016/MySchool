//
//  TeacherPresenter.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import Combine

class TeacherPresenter: ObservableObject {
    @Published var teachers: [Teacher] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let interactor: TeacherInteractorProtocol
    private let store: Store<TeacherState, TeacherAction>
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: TeacherInteractorProtocol, store: Store<TeacherState, TeacherAction>) {
        self.interactor = interactor
        self.store = store
        
        store.$state
            .map(\.teachers)
            .assign(to: &$teachers)
        
        store.$state
            .map(\.isLoading)
            .assign(to: &$isLoading)
        
        store.$state
            .map(\.error)
            .assign(to: &$error)
    }
    
    func loadTeachers() {
        store.send(.setLoading(true))
        Task {
            do {
                let teachers = try await interactor.fetchTeachers()
                await MainActor.run {
                    store.send(.teachersLoaded(teachers))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func addTeacher(_ teacher: Teacher) {
        Task {
            do {
                try await interactor.createTeacher(teacher)
                await MainActor.run {
                    store.send(.addTeacher(teacher))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func updateTeacher(_ teacher: Teacher) {
        Task {
            do {
                try await interactor.updateTeacher(teacher)
                await MainActor.run {
                    store.send(.updateTeacher(teacher))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func deleteTeacher(_ teacher: Teacher) {
        Task {
            do {
                try await interactor.deleteTeacher(teacher)
                await MainActor.run {
                    store.send(.deleteTeacher(teacher))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func selectTeacher(_ teacher: Teacher?) {
        store.send(.selectTeacher(teacher))
    }
}
