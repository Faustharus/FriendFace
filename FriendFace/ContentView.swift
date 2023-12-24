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
    //@State private var users = [User]()
    
    var body: some View {
        NavigationStack {
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
            .onAppear(perform: loadDataIfNeeded)
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
        }
    }
}

#Preview {
    let preview = PreviewContainer([User.self])
    preview.add(items: User.sample(0))
    return ContentView()
        .modelContainer(preview.container)
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
                        for friend in user.friends {
                            modelContext.insert(friend)
                        }
                    }
                    //self.users = try jsonDecoder.decode([User].self, from: data)
                } catch {
                    print("Error decoding JSON Data: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func loadDataIfNeeded() {
        if allUsers.isEmpty {
            downloadJSONData()
        }
    }
    
}
