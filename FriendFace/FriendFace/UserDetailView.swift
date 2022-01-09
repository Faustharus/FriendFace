//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 05/01/2022.
//

import SwiftUI

struct UserDetailView: View {
    let users: CachedUser

    @State private var contactMe = false

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Text(users.wrappedName)
                        .font(.title.bold())

                    Text(users.wrappedCompany)
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)

                Spacer()

                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .overlay(
                        VStack {
                            Image(systemName: "circlebadge.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(users.isActive ? .green : .gray)
                                .offset(x: 20, y: 20)
                        }
                    )
            }
            .padding(.horizontal, 15)

            dividers

            VStack(alignment: .center) {
                Text("About Me:")
                    .font(.title2.weight(.bold))
                    .underline()
                    .padding(.vertical, 5)
                
                if contactMe {
                    contactsDetails
                } else {
                    Text(users.wrappedAbout)
                        .font(.headline.weight(.regular))
                        .multilineTextAlignment(.center)
                        .layoutPriority(1)
                        .padding(.horizontal, 5)
                }
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            Text("\(users.wrappedTags) ")
                                .font(.headline)
//                            }
                        }
                        .padding(.all, 10)
                    }
                }
            }

            VStack {
                Toggle(isOn: $contactMe) {
                    Text(contactMe ? "There it is !!" : "Contact Me ?")
                        .foregroundColor(.white)
                        .font(.title2.weight(.heavy))
                }
                .padding(.horizontal, 80)
            }
            .frame(height: 55)
            .shadow(color: .black, radius: 5, x: 10, y: 10)
            .background(Color.blue)
            .cornerRadius(20)
            .padding()

            dividers

            Section(header: Text("Friends of \(users.wrappedName)").textCase(.uppercase)) {
                List(users.friendsArray, id: \.id) { item in
                    Text(item.wrappedName)
                }
                .listStyle(.plain)
            }
            .padding(.all, 5)

            Spacer()

            dividers

            Text("Registered on: \(users.registered ?? Date.now, format: .dateTime)")
                .font(.headline.weight(.regular))
                .italic()

        }
        .navigationTitle("Status: \(users.isActive ? "Active" : "Inactive")")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailView(users: User.dummyUser.first!)
//    }
//}

// MARK: - View Components
extension UserDetailView {

    private var contactsDetails: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [Color.red, Color.purple], startPoint: .top, endPoint: .bottom))
                .frame(height: 100)
            VStack(alignment: .leading) {
                HStack {
                    Text("Address: ")
                        .font(.title3)
                        .bold()
                    Text(users.wrappedAddress)
                        .font(.caption)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.all, 2)

                HStack {
                    Text("Email :")
                        .font(.title2)
                        .bold()
                    Text(users.wrappedEmail)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.all, 2)

            }
        }
    }

    private var dividers: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondary)
                .frame(height: 5)
        }
    }

}
