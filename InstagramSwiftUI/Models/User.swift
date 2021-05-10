//
//  User.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 07.05.2021.
//

import FirebaseFirestoreSwift


struct User: Identifiable, Decodable {
    let username: String
    let email: String
    let profileImageUrl: String
    let fullname: String
    var isFollowed: Bool? = false
    var stats: UserStats?
    @DocumentID var id: String?
    
    var bio: String? 
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}
