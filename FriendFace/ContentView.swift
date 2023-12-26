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
    
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(allUsers) { user in
                HStack {
                    ZStack {
                        NavigationLink(value: user) {
                            
                            ZStack {
                                Circle()
                                    .stroke(user.isActive ? .green : .red, lineWidth: 2)
                                    .frame(width: 55)
                                VStack {
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(user.name)")
                                    .font(.title)
                                    .fontWeight(.medium)
                                Text(user.isActive ? "Online" : "Offline")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
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
