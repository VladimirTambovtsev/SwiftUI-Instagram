//
//  Notification.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 10.05.2021.
//

import Firebase
import FirebaseFirestoreSwift


struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var userIsFollowed: Bool? = false
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notifcationMessage: String {
        switch self {
            case .like: return " liked one of your posts."
            case .comment: return " commented one of your posts."
            case .follow: return " started following you."
        }
    }
}
