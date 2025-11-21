//
//  ContentView.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(AppStore.self) private var store
    
    var body: some View {
        @Bindable var store = store
        
        TabView(selection: Binding(
            get: { store.state.navigationState.selectedTab },
            set: { store.send(.navigationAction(.selectTab($0))) }
        )) {
            StudentListView()
                .tabItem {
                    Label("Students", systemImage: "person.3")
                }
                .tag(AppTab.students)
            
            TeacherListView()
                .tabItem {
                    Label("Teachers", systemImage: "person.badge.shield.checkmark")
                }
                .tag(AppTab.teachers)
            
            AdminListView()
                .tabItem {
                    Label("Admins", systemImage: "person.crop.square")
                }
                .tag(AppTab.admins)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
