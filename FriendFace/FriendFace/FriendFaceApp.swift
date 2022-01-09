//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 04/01/2022.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
