//
//  StudentListView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI
import SwiftData

struct StudentListView: View {
    @Environment(AppStore.self) private var store
    @State private var presenter: StudentPresenter?
    @Query private var students: [Student]
    
    var body: some View {
        NavigationStack {
            Group {
                if presenter?.isLoading == true {
                    ProgressView("Loading students...")
                } else if let error = presenter?.error {
                    ErrorView(error: error) {
                        presenter?.loadStudents()
                    }
                } else {
                    List {
                        ForEach(students, id: \.id) { student in
                            NavigationLink(value: AppRoute.studentDetail(student)) {
                                StudentRowView(student: student)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    presenter?.deleteStudent(student)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Students")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .studentDetail(let student):
                    StudentDetailView(student: student)
                case .addStudent:
                    AddStudentView()
                default:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Student", systemImage: "plus") {
                        store.send(.navigationAction(.navigateTo(.addStudent)))
                    }
                }
            }
        }
        .onAppear {
            setupPresenter()
            presenter?.loadStudents()
        }
    }
    
    private func setupPresenter() {
        let modelContext = ModelContext(store.modelContainer)
        let interactor = StudentInteractor(modelContext: modelContext)
        let studentStore = store.derived(
            deriveState: \.studentState,
            embedAction: AppAction.studentAction
        )
        presenter = StudentPresenter(interactor: interactor, store: studentStore)
    }
}

#Preview {
    StudentListView()
}
