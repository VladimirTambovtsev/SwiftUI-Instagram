//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 07.05.2021.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var posts = [Post]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { snapshot, err in
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
                guard let username = dictionary["username"] as? String else {return}
                guard let fullname = dictionary["fullname"] as? String else {return}
                guard let email = dictionary["email"] as? String else {return}
                guard let profileImageUrl = dictionary["profileImageUrl"] as? String else {return}
                guard let uid = dictionary["uid"] as? String else {return}

                let user = User(username: username, email: email, profileImageUrl: profileImageUrl, fullname: fullname, id: uid)
                self.users.append(user)
            }
        }
    }
    
    func filterUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery) })
    }
    
    
}
