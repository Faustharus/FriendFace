//
//  UserProfileView.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 06/01/2022.
//

import SwiftUI

struct UserProfileView: View {
    let users: CachedUser
    
    var body: some View {
            VStack {
                ZStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.red)
                        .shadow(color: .black, radius: 5, x: 0, y: 10)
                        .background()
                        .padding()
                    VStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(users.isActive ? .green : .gray)
                            .offset(x: 40, y: 50)
                    }
                }
                
                VStack(alignment: .center) {
                    Text(users.wrappedName)
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                    
                    Text("\(users.wrappedCompany)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 3)
                }
            }
        
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            VStack {
//                UserProfileView(users: User.dummyUser.first!)
//                UserProfileView(users: User.dummyUser.first!)
//                UserProfileView(users: User.dummyUser.first!)
//            }
//        }
//    }
//}
