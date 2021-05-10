//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()

    init() {
        fetchPosts()
    }
    
    func fetchPosts() { 
        Firestore.firestore().collection("posts").order(by: "timestamp", descending: true).getDocuments { snapshot, err in
            if let err = err {
                print("DEBUG: Error fetching users: \(err.localizedDescription)")
                return
            }
            guard (snapshot?.documents) != nil else {
                print("DEBUG: documents not found: \(String(describing: snapshot?.documents))")
                return
            }
            
            for document in snapshot!.documents {
//                print("\(document.documentID) => \(document.data())")
                
                let dictionary = document.data()
                
                let id = document.documentID
                guard let caption = dictionary["caption"] as? String else {return}
                guard let ownerId = dictionary["ownerId"] as? String else {return}
                guard let likes = dictionary["likes"] as? Int else {return}
                guard let imageUrl = dictionary["imageUrl"] as? String else {return}
                guard let ownerImageUrl = dictionary["ownerImageUrl"] as? String else {return}
                guard let ownerUsername = dictionary["ownerUsername"] as? String else {return}
                guard let timestamp = dictionary["timestamp"] as? Timestamp else {return}
                
                let post = Post(id: id, ownerId: ownerId,
                                caption: caption, likes: likes, imageUrl: imageUrl,
                                ownerImageUrl: ownerImageUrl, ownerUsername: ownerUsername, timestamp: timestamp)
                self.posts.append(post)
            }
        }
    }
}
