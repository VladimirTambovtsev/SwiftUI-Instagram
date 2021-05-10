//
//  CommnetsViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI
import Firebase

class CommentsViewModel: ObservableObject {
    
    private let post: Post
    @Published var comments = [Comment]()

    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard let userId = user.id else {return}
        guard let postId = post.id else {return}
        
        let data = ["username": user.username,
                    "profileImageUrl": user.profileImageUrl,
                    "uid": userId,
                    "timestamp": Timestamp(date: Date()),
                    "postOwnerId": post.ownerId,
                    "commentText": commentText
        ] as [String : Any]
        
        Firestore.firestore()
            .collection("posts").document(postId)
            .collection("post-comments").addDocument(data: data) { err in
                if err != nil {
                    print("DEBUG: Error sending comment \(String(describing: err?.localizedDescription))")
                    return
                }
                
                NotificationsViewModel.uploadNotification(toUid: self.post.ownerId, type: .comment, post: self.post)
            }
        
    }
    
    func fetchComments() {
        guard let postId = post.id else { return }
        let query = Firestore.firestore()
            .collection("posts").document(postId)
            .collection("post-comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, err in
            if err != nil {
                print("DEBUG: Error fetching comments: \(String(describing: err?.localizedDescription))")
                return
            }
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else {return}
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Comment.self) }))
        }
    }
}
