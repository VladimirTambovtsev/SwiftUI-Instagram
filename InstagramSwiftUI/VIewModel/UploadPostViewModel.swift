//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    func uploadPost(caption: String, image: UIImage, completion: ((Error?) -> Void)?) {
        guard let user = AuthViewModel.shared.currentUser else {return}
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageUrl": imageUrl,
                "ownerId": user.id ?? "",
                "ownerImageUrl": user.profileImageUrl,
                "ownerUsername": user.username
            ] as [String : Any]
            Firestore.firestore().collection("posts").addDocument(data: data, completion: completion)
        }
    }
}
