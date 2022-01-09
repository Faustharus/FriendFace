//
//  ContentView.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 04/01/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var usersData: FetchedResults<CachedUser>
    @StateObject private var vm = UserViewModelImpl(service: UserServiceImpl())
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(usersData, id: \.id) { item in
                        NavigationLink(destination: UserDetailView(users: item)) {
                            UserProfileView(users: item)
                        }
                    }
                }
                .task {
                    await vm.fetch()
                }
            }
            .navigationTitle("FriendFace")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
