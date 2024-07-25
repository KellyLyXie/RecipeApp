//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
