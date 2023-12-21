//
//  UserView.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 21/12/2023.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    
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
                    .frame(width: .infinity, height: 3)
                
                
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
                    .frame(width: .infinity, height: 3)
                
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
                    .frame(width: .infinity, height: 3)
                
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
                    .frame(width: .infinity, height: 3)
                
                // MARK: Friend Section
                VStack {
                    Text("Friends")
                        .font(.title)
                    VStack {
                        ForEach(user.friends, id: \.id) { item in
                            Text(item.name)
                        }
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    UserView(user: User.init(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: .now, tags: ["cillum","consequat","deserunt","nostrud","eiusmod","minim","tempor"], friends: [User.Friend.init(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")]))
    
}

// MARK: Functions & Computed Properties
extension UserView {
    
    
    
}
