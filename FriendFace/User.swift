//
//  User.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 21/12/2023.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct User: Identifiable, Codable, Hashable {
    struct Friend: Identifiable, Codable, Hashable {
        var id: String
        var name: String
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
    var friends: [Friend]
    
    var publishedDate: String {
        return relativeDateFormatter.localizedString(for: registered, relativeTo: Date())
    }
}
