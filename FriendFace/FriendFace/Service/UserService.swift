//
//  UserService.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 06/01/2022.
//

import Foundation
import SwiftUI

protocol UserService {
    func fetchUsers() async
}

final class UserServiceImpl: UserService {
    
    func fetchUsers() async {
        do {
            let urlSession = URLSession.shared
            let url = URL(string: APIConstant.baseURL)
            let (data, _) = try await urlSession.data(from: url!)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let array = try decoder.decode([User].self, from: data)
            await MainActor.run {
                updateCache(with: array)
                print("Data Saved: \(array.count)")
            }
        } catch {
            print("Something wrong occur...")
        }
        
    }
    
    func updateCache(with downloadedUsers: [User]) {
        for user in downloadedUsers {
            let cachedUser = CachedUser(context: User.moc)

            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")

            for friend in user.friends {
                let cachedFriend = CachedFriend(context: User.moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                cachedUser.addToFriends(cachedFriend)
            }
        }

        try? User.moc.save()
    }
    
}
