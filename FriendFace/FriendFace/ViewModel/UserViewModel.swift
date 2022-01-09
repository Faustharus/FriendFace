//
//  UserViewModel.swift
//  FriendFace
//
//  Created by Damien Chailloleau on 06/01/2022.
//

import CoreData
import Foundation
import SwiftUI

protocol UserViewModel: ObservableObject {
    func fetch() async
}

@MainActor
final class UserViewModelImpl: UserViewModel {

    let service: UserService

    init(service: UserService) {
        self.service = service
    }
    
    func fetch() async {
        await service.fetchUsers()
        print("Data Fetched")
    }

}
