//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    var likeString: String {
        return "\(post.likes)"
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        Firestore.firestore()
            .collection("posts").document(postId)
            .collection("post-likes").document(uid)
            .setData([:]) { _ in
                
                Firestore.firestore()
                    .collection("users").document(uid)
                    .collection("user-likes").document(postId)
                    .setData([:]) { _ in
                        
                        Firestore.firestore()
                            .collection("posts").document(postId)
                            .updateData(["likes": self.post.likes + 1])
                        
                        NotificationsViewModel.uploadNotification(toUid: self.post.ownerId, type: .like, post: self.post)
                        
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
    }
    
    func unlike() {
        guard post.likes > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        Firestore.firestore()
            .collection("posts").document(postId)
            .collection("post-likes").document(uid)
            .delete() { _ in
                Firestore.firestore()
                    .collection("users").document(uid)
                    .delete() { _ in
                        
                        Firestore.firestore()
                            .collection("posts").document(postId)
                            .updateData(["likes": self.post.likes + 1])
                        
                        self.post.didLike = false
                        self.post.likes -= 1
                    }
            }
    }
    
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        Firestore.firestore()
            .collection("users").document(uid)
            .collection("user-likes").document(postId)
            .getDocument { snapshot, _ in
                guard let didLike = snapshot?.exists else {return}
                self.post.didLike = didLike
            }
    }
}
