//
//  ContentView.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 21/12/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment (\.modelContext) var modelContext
    @Query var allUsers: [User]
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            Text("Query Data : \(allUsers.count)")
            Text("Friends Data : \(allUsers[2].friends.count)")
            Text("DL Data : \(users.count)")
            List(allUsers) { user in
                HStack {
                    NavigationLink(value: user) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(user.name)")
                                .font(.title)
                                .fontWeight(.medium)
                            HStack {
                                Circle()
                                    .fill(user.isActive ? .green : .red)
                                    .frame(width: 20)
                                Text(user.isActive ? "Online" : "Offline")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
            .onAppear(perform: allUsers.isEmpty ? downloadJSONData : storingUsersData)
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .toolbar {
                Button {
                    //storingUsersData(items: allUsers)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

// MARK: Functions
extension ContentView {
    
    func downloadJSONData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                print("Error detected: \(err.localizedDescription)")
            } else if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    let allUsers = try jsonDecoder.decode([User].self, from: data)
                    for user in allUsers {
                        modelContext.insert(user)
//                        for friend in allUsers[user.id.count].friends {
//                            modelContext.insert(friend)
//                        }
                    }
                    //self.users = try jsonDecoder.decode([User].self, from: data)
                } catch {
                    print("Error decoding JSON Data: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func storingUsersData() {
//        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try? ModelContainer(for: User.self, configurations: configuration)
        
//        Task { @MainActor in
//            users.forEach { user in
//                let userToSave = container?.mainContext
//                
//            }
//        }
        
//        Task { @MainActor in
//            items.forEach { container?.mainContext.insert($0) }
//        }
    }
    
}
