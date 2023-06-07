//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Thongchai Subsaidee on 7/6/23.
//

import SwiftUI

@main
struct SwiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Book.self])
        }
    }
}
