//
//  PostGridViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI
import Firebase

enum PostGridConfiguration {
    case explore
    case profile(String)
}

class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    let config: PostGridConfiguration
 
    init(config: PostGridConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGridConfiguration) {
        switch config {
        case .explore:
            fetchExplorePagePosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    func fetchExplorePagePosts() {
        Firestore.firestore().collection("posts").getDocuments { snapshot, err in
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
                guard let caption = dictionary["caption"] as? String else {return}
                guard let ownerId = dictionary["ownerId"] as? String else {return}
                guard let likes = dictionary["likes"] as? Int else {return}
                guard let imageUrl = dictionary["imageUrl"] as? String else {return}
                guard let ownerImageUrl = dictionary["ownerImageUrl"] as? String else {return}
                guard let ownerUsername = dictionary["ownerUsername"] as? String else {return}
                guard let timestamp = dictionary["timestamp"] as? Timestamp else {return}
                
                let post = Post(ownerId: ownerId,
                                caption: caption, likes: likes, imageUrl: imageUrl,
                                ownerImageUrl: ownerImageUrl, ownerUsername: ownerUsername, timestamp: timestamp)
                self.posts.append(post)
            }
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        Firestore.firestore().collection("posts").whereField("ownerId", isEqualTo: uid).getDocuments { snapshot, err in
            if let err = err {
                print("DEBUG: Error fetching users: \(err.localizedDescription)")
                return
            }
            guard (snapshot?.documents) != nil else {
                print("DEBUG: documents not found: \(String(describing: snapshot?.documents))")
                return
            }
            
            var unsortedPosts = [Post]()
            
            for document in snapshot!.documents {
//                print("\(document.documentID) => \(document.data())")
                
                let dictionary = document.data()
                guard let caption = dictionary["caption"] as? String else {return}
                guard let ownerId = dictionary["ownerId"] as? String else {return}
                guard let likes = dictionary["likes"] as? Int else {return}
                guard let imageUrl = dictionary["imageUrl"] as? String else {return}
                guard let ownerImageUrl = dictionary["ownerImageUrl"] as? String else {return}
                guard let ownerUsername = dictionary["ownerUsername"] as? String else {return}
                guard let timestamp = dictionary["timestamp"] as? Timestamp else {return}
                
                let post = Post(ownerId: ownerId,
                                caption: caption, likes: likes, imageUrl: imageUrl,
                                ownerImageUrl: ownerImageUrl, ownerUsername: ownerUsername, timestamp: timestamp)
                unsortedPosts.append(post)
            }
            self.posts = unsortedPosts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
            unsortedPosts = [Post]()
        }
    }
}
