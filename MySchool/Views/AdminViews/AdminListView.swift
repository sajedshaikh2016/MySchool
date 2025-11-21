//
//  AdminListView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI
import SwiftData

struct AdminListView: View {
    @Environment(AppStore.self) private var store
    @State private var presenter: AdminPresenter?
    @Query private var users: [User]
    
    var body: some View {
        NavigationStack {
            Group {
                if presenter?.isLoading == true {
                    ProgressView("Loading users...")
                } else if let error = presenter?.error {
                    ErrorView(error: error) {
                        presenter?.loadUsers()
                    }
                } else {
                    List {
                        ForEach(users, id: \.id) { user in
                            NavigationLink(value: AppRoute.adminDetail(user)) {
                                AdminRowView(user: user)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    presenter?.deleteUser(user)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Administrators")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .adminDetail(let user):
                    AdminDetailView(user: user)
                case .addAdmin:
                    AddAdminView()
                default:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Admin", systemImage: "plus") {
                        store.send(.navigationAction(.navigateTo(.addAdmin)))
                    }
                }
            }
        }
        .onAppear {
            setupPresenter()
            presenter?.loadUsers()
        }
    }
    
    private func setupPresenter() {
        let modelContext = ModelContext(store.modelContainer)
        let interactor = AdminInteractor(modelContext: modelContext)
        let adminStore = store.derived(
            deriveState: \.adminState,
            embedAction: AppAction.adminAction
        )
        presenter = AdminPresenter(interactor: interactor, store: adminStore)
    }
}

#Preview {
    AdminListView()
}
