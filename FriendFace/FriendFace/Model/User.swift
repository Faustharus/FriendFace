//
//  User.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 04/01/2022.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}

extension User {
    @Environment(\.managedObjectContext) static var moc
}

extension User {

    static var dummyUser: [User] = [
        User.init(id: UUID(), isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit …ion irure est deserunt.", registered: Date.now, tags: ["cillum", "consequat", "desernut", "nostrud", "eiusmod", "minim", "tempor"], friends: [Friend.init(id: UUID(), name: "Hawkins Patel")]),
        User.init(id: UUID(), isActive: true, name: "Helena Tanak", age: 27, company: "Cotal", email: "helenatanak@cotal.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit …ion irure est deserunt.", registered: Date.now, tags: ["cillum", "consequat", "desernut", "nostrud"], friends: [Friend.init(id: UUID(), name: "Alford Rodriguez")])
    ]

}
