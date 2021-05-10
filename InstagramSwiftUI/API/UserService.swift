//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import Foundation
import Firebase

struct UserService {
    
    static func follow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore()
            .collection("following").document(currentUid)
            .collection("user-following").document(uid)
            .setData([:]) { err in
                if err != nil {
                    print("DEBUG: Error following user: \(String(describing: err?.localizedDescription))")
                    return
                }
                Firestore.firestore()
                    .collection("followers").document(uid)
                    .collection("user-followers").document(currentUid)
                    .setData([:], completion: completion)
            }
        
    }
    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore()
            .collection("following").document(currentUid)
            .collection("user-following").document(uid)
            .delete() { _ in
                Firestore.firestore()
                    .collection("followers").document(uid)
                    .collection("user-followers").document(currentUid)
                    .delete(completion: completion)
            }
    }
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore()
            .collection("following").document(currentUid)
            .collection("user-following").document(uid)
            .getDocument { snapshot, err in
                if err != nil {
                    print("DEBUG: Error checking if user if followed: \(String(describing: err?.localizedDescription))")
                    return
                }
                guard let isFollowed = snapshot?.exists else {return}
                completion(isFollowed)
            }
    }
}
