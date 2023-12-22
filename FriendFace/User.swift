//
//  User.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 21/12/2023.
//

import Foundation
import SwiftData

//fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

@Model
class User: Identifiable, Codable, Hashable {
//    struct Friend: Identifiable, Codable, Hashable {
//        var id: String
//        var name: String
//    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        //case friends
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    //var friends: [Friend]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let stringIsActive = try container.decode(String.self, forKey: .isActive)
        self.isActive = Bool(stringIsActive) ?? false
        self.name = try container.decode(String.self, forKey: .name)
        let stringAge = try container.decode(String.self, forKey: .age)
        self.age = Int(stringAge) ?? 0
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        let stringRegistered = try container.decode(String.self, forKey: .registered)
        self.registered = try Date(stringRegistered, strategy: .iso8601)
        self.tags = try container.decode([String].self, forKey: .tags)
        //self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        //try container.encode(self.friends, forKey: .friends)
    }
    
//    var publishedDate: String {
//        return relativeDateFormatter.localizedString(for: registered, relativeTo: Date())
//    }
    
//    init() {
//        self.friends = user.map { member in
//            if let user = users[member.name] {
//                // return Friend(name)
//            }
//        }
//    }
}
