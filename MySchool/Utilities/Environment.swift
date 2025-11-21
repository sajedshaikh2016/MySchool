//
//  Environment.swift
//  MySchool
//
//  Created by Sajed Shaikh on 20/11/25.
//

import Foundation
import SwiftUI

private struct AppStoreKey: EnvironmentKey {
    static let defaultValue: AppStore? = nil
}

extension EnvironmentValues {
    var store: AppStore? {
        get { self[AppStoreKey.self] }
        set { self[AppStoreKey.self] = newValue }
    }
}

extension AppStore: ObservableObject { }
