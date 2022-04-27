//
//  GServApp.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 03.12.2021.
//

import SwiftUI

enum AppState {
    case unregistered
    case loggedin
}

@main
struct GServApp: App {
    @State static var appstate: AppState = .unregistered
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
