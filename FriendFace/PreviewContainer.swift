//
//  PreviewContainer.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 24/12/2023.
//

import SwiftData

struct PreviewContainer {
    
    let container: ModelContainer!
    
    init(_ types: [any PersistentModel.Type]) {
        let schema = Schema(types)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        self.container = try! ModelContainer(for: schema, configurations: [configuration])
    }
    
    func add(items: [any PersistentModel]) {
        Task { @MainActor in
            items.forEach { container.mainContext.insert($0) }
        }
    }
}
