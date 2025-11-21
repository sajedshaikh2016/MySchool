//
//  Store.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import Combine

typealias AppStore = Store<AppState, AppAction>

class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private var cancellables: Set<AnyCancellable> = []
    
    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        reducer(&state, action)
    }
    
    func derived<DerivedState: Equatable, DerivedAction>(
        deriveState: @escaping (State) -> DerivedState,
        embedAction: @escaping (DerivedAction) -> Action
    ) -> Store<DerivedState, DerivedAction> {
        let derivedStore = Store<DerivedState, DerivedAction>(
            initialState: deriveState(state),
            reducer: Reducer { _, _ in }
        )
        
        $state
            .map(deriveState)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: derivedStore)
            .store(in: &cancellables)
        
        derivedStore.send = { [weak self] action in
            self?.send(embedAction(action))
        }
        
        return derivedStore
    }
}

class Reducer<State, Action> {
    private let reduce: (inout State, Action) -> Void
    
    init(_ reduce: @escaping (inout State, Action) -> Void) {
        self.reduce = reduce
    }
    
    func callAsFunction(_ state: inout State, _ action: Action) {
        reduce(&state, action)
    }
}
