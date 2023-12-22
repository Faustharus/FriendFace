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
            List(users) { user in
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
            .onAppear(perform: downloadJSONData)
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = ModelContainer(for: User.self, configurations: config)
        let dummyUser = User(from: <#T##Decoder#>)
        
        return ContentView()
            .modelContainer(for: User.self)
    } catch {
        return Text("Failed to show all users: \(error.localizedDescription)")
    }
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
                    self.users = try jsonDecoder.decode([User].self, from: data)
                } catch {
                    print("Error decoding JSON Data: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func storingUsersData() {
//        let newExpense = Expenses(name: name, type: type.rawValue, amount: amount)
//        modelContext.insert(newExpense)
    }
    
}
