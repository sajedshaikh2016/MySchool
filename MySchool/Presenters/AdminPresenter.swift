//
//  AdminPresenter.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import Combine

class AdminPresenter: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let interactor: AdminInteractorProtocol
    private let store: Store<AdminState, AdminAction>
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: AdminInteractorProtocol, store: Store<AdminState, AdminAction>) {
        self.interactor = interactor
        self.store = store
        
        store.$state
            .map(\.users)
            .assign(to: &$users)
        
        store.$state
            .map(\.isLoading)
            .assign(to: &$isLoading)
        
        store.$state
            .map(\.error)
            .assign(to: &$error)
    }
    
    func loadUsers() {
        store.send(.setLoading(true))
        Task {
            do {
                let users = try await interactor.fetchUsers()
                await MainActor.run {
                    store.send(.usersLoaded(users))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func addUser(_ user: User) {
        Task {
            do {
                try await interactor.createUser(user)
                await MainActor.run {
                    store.send(.addUser(user))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func updateUser(_ user: User) {
        Task {
            do {
                try await interactor.updateUser(user)
                await MainActor.run {
                    store.send(.updateUser(user))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func deleteUser(_ user: User) {
        Task {
            do {
                try await interactor.deleteUser(user)
                await MainActor.run {
                    store.send(.deleteUser(user))
                }
            } catch {
                await MainActor.run {
                    store.send(.setError(error.localizedDescription))
                }
            }
        }
    }
    
    func selectUser(_ user: User?) {
        store.send(.selectUser(user))
    }
}
