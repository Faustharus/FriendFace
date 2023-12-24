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
    // TODO: $Path Need for the Friends of the User <- Done ✅
    // TODO: Using User.Friend as anchor to the get the info as User for each Friend <- Done ✅
    // TODO: Redesigning the UI
    
    var body: some View {
        ScrollView {
            VStack {
                // MARK: Info Title Section
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(user.name)
                            .font(.title.bold())
                        HStack {
                            Circle()
                                .fill(user.isActive ? .green : .red)
                                .frame(width: 20)
                            Text(user.isActive ? "Online" : "Offline")
                                .font(.system(size: 18, weight: .black, design: .default))
                        }
                    }
                }
                
                Rectangle()
                    .foregroundStyle(.secondary)
                    .frame(width: 300, height: 3)
                
                
                // MARK: Details Section
                VStack {
                    Text("Details")
                        .font(.title)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Âge : \(user.age)")
                            
                            Spacer()
                            
                            Text("\(user.registered.formatted(date: .numeric, time: .omitted)) : Registered")
                        }
                        HStack {
                            Text("Company : \(user.company)")
                            
                            Spacer()
                            
                            Text("\(user.email)")
                        }
                        
                    }
                    .font(.subheadline.italic())
                    .padding([.top, .horizontal], 5)
                }
                
                Rectangle()
                    .foregroundStyle(.secondary)
                    .frame(width: 300, height: 3)
                
                // MARK: Tag Section
                VStack(spacing: 0) {
                    Text("Tags")
                        .font(.title)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tagItem in
                                Text("#\(tagItem)")
                                    .font(.headline)
                                    .italic()
                            }
                        }
                        .padding([.top, .horizontal], 10)
                    }
                }
                
                Rectangle()
                    .foregroundStyle(.secondary)
                    .frame(width: 300, height: 3)
                
                // MARK: About Section
                VStack {
                    Text("About")
                        .font(.title)
                    Text("\(user.about)")
                        .font(.headline)
                }
                .padding(.horizontal, 20)
                
                Rectangle()
                    .foregroundStyle(.secondary)
                    .frame(width: 300, height: 3)
                
                // MARK: Friend Section
                VStack {
                    Text("Friends")
                        .font(.title)
                    VStack {
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
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    let preview = PreviewContainer([User.self])
    let users = User.sample(1)
    preview.add(items: users)
    return UserView(user: users[0])
        .modelContainer(preview.container)
}

extension UserView {
    
    private func getFriendUserPage(_ friend: Friend) -> User? {
        guard let user = allUsers.first(where: { $0.id == friend.id }) else {
            return User.dummy
        }
        return user
    }
    
}
