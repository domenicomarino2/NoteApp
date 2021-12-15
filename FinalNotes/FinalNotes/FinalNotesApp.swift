//
//  FinalNotesApp.swift
//  FinalNotes
//
//  Created by Domenico Marino on 12/12/21.
//

import SwiftUI

@main
struct FinalNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
