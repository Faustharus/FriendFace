//
//  UserView.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 21/12/2023.
//

import SwiftData
import SwiftUI

struct UserView: View {
    @Environment(\.modelContext) var modelContext
    @Query var allUsers: [User]
    
    let user: User
    
    var body: some View {
        Form {
            Section("Status") {
                HStack {
                    Circle()
                        .foregroundStyle(user.isActive ? .green : .red)
                        .frame(width: 22)
                    
                    Text(user.isActive ? "Online" : "Offline")
                        .foregroundStyle(user.isActive ? .green : .red)
                        .bold()
                }
                .padding(.horizontal, 10)
            }
            
            Section("Registered") {
                Text("\(user.registered.formatted(date: .long, time: .omitted))")
            }
            
            Section("Details") {
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("Company: \(user.company)")
                Text("Address: \(user.address)")
            }
            
            Section("Tags") {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.tags, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
            
            Section("About") {
                Text("\(user.about)")
            }
            
            Section("Friends") {
                ForEach(user.friends, id: \.id) { item in
                    if let friendUser = getFriendUserPage(item) {
                        NavigationLink(destination: UserView(user: friendUser)) {
                            Text(item.name)
                        }
                    } else {
                        Text("Friend Not Found")
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    NavigationStack {
        let preview = PreviewContainer([User.self])
        let users = User.sample(1)
        preview.add(items: users)
        return UserView(user: users[0])
            .modelContainer(preview.container)
    }
}

extension UserView {
    
    private func getFriendUserPage(_ friend: Friend) -> User? {
        guard let user = allUsers.first(where: { $0.id == friend.id }) else {
            return User.dummy
        }
        return user
    }
    
}
