//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 10.05.2021.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func saveUserData(bio: String) {
        guard let uid = user.id else {return}
        Firebase.Firestore.firestore()
            .collection("users").document(uid)
            .updateData(["bio": bio]) { err in
                if err != nil {
                    print("DEBUG: Error saving bio data: \(String(describing: err?.localizedDescription))")
                    return
                }
                self.user.bio = bio
                self.uploadComplete = true
            }
    }
}
