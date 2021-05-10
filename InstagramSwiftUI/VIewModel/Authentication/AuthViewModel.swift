//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 06.05.2021.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendResetPassword = false
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login failed: \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
        }
    }
    func register(withEmail email: String, withPassword password: String, image: UIImage?, fullname: String, username: String) {
        print("invoked register")
        guard let image = image else { return }
        
//        Upload image to filestorage
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            print("Successfully uploaded image")
            
//            Create user in Authentication Firestore
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else {return}
                self.userSession = user
                print("Successfully registered user")
                
//                Save user data in Database Firestore
                let data = [
                    "email": email,
                    "username": username,
                    "fullname": fullname,
                    "profileImageUrl": imageUrl,
                    "uid": user.uid
                ]
                Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                    self.userSession = user
                    self.fetchUser()
                    print("Successfully uploaded user data")
                }
            }
        }
    }
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if err != nil {
                print("DEBUG: Error resetting password: \(String(describing: err?.localizedDescription))")
                return
            }
            self.didSendResetPassword = true
        }
    }
    
    func fetchUser() {
        print("fetchUser()")

        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { document, err in
            if err != nil {
                print("DEBUG: error fetching user: \(String(describing: err?.localizedDescription))")
                return
            }
            if let document = document {
//               print("Cached document data: \(document)")
                guard let dictionary = document.data() else {return}
                
                guard let username = dictionary["username"] as? String else {return}
                guard let fullname = dictionary["fullname"] as? String else {return}
                guard let email = dictionary["email"] as? String else {return}
                guard let profileImageUrl = dictionary["profileImageUrl"] as? String else {return}
                guard let uid = dictionary["uid"] as? String else {return}
                
                let user = User(username: username, email: email, profileImageUrl: profileImageUrl, fullname: fullname, id: uid)
                self.currentUser = user
                print("self.currentUser: ", self.currentUser)
                print("isCurrentUser: ", self.currentUser?.isCurrentUser)
             } else {
               print("Document does not exist in cache")
             }
        }
    }
}
