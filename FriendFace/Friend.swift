//
//  Friend.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 23/12/2023.
//

import Foundation
import SwiftData

@Model
final class Friend: Identifiable, Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    var id: String
    var name: String
    
    init(id: String = "1", name: String = "Jane Doe") {
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}

extension Friend {
    static var dummy: Friend {
        .init(id: "1", name: "Jane Doe")
    }
    
    static func sample(_ num: Int) -> [Friend] {
        var friends: [Friend] = []
        
        for i in 0 ..< num {
            friends.append(.init(id: "ID\(i)", name: "Name\(i)"))
        }
        
        return friends
    }
}
