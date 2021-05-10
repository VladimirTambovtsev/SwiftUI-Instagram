//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Decodable {    
    @DocumentID var id: String?
    let ownerId: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let ownerImageUrl: String
    let ownerUsername: String
    let timestamp: Timestamp
    
    var didLike: Bool? = false
}
