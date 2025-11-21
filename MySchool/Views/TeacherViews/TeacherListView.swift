//
//  TeacherListView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI
import SwiftData

struct TeacherListView: View {
    @Environment(AppStore.self) private var store
    @State private var presenter: TeacherPresenter?
    @Query private var teachers: [Teacher]
    
    var body: some View {
        NavigationStack {
            Group {
                if presenter?.isLoading == true {
                    ProgressView("Loading teachers...")
                } else if let error = presenter?.error {
                    ErrorView(error: error) {
                        presenter?.loadTeachers()
                    }
                } else {
                    List {
                        ForEach(teachers, id: \.id) { teacher in
                            NavigationLink(value: AppRoute.teacherDetail(teacher)) {
                                TeacherRowView(teacher: teacher)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    presenter?.deleteTeacher(teacher)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Teachers")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .teacherDetail(let teacher):
                    TeacherDetailView(teacher: teacher)
                case .addTeacher:
                    AddTeacherView()
                default:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Teacher", systemImage: "plus") {
                        store.send(.navigationAction(.navigateTo(.addTeacher)))
                    }
                }
            }
        }
        .onAppear {
            setupPresenter()
            presenter?.loadTeachers()
        }
    }
    
    private func setupPresenter() {
        let modelContext = ModelContext(store.modelContainer)
        let interactor = TeacherInteractor(modelContext: modelContext)
        let teacherStore = store.derived(
            deriveState: \.teacherState,
            embedAction: AppAction.teacherAction
        )
        presenter = TeacherPresenter(interactor: interactor, store: teacherStore)
    }
}

#Preview {
    TeacherListView()
}
