//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 10.05.2021.
//

import SwiftUI
import Firebase

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications() {
        print("fetchNotifications() ")
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        let query =  Firestore.firestore()
            .collection("notifications").document(uid)
            .collection("user-notifications").order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, err in
            if err != nil {
                print("DEBUG: Error fetching notificaitons: \(String(describing: err?.localizedDescription))")
                return
            }
            guard (snapshot?.documents) != nil else {return}
            
            for document in snapshot!.documents {
//                print("\(document.documentID) => \(document.data())")
                
                let dictionary = document.data()
                let postId = dictionary["postId"] as? String?
                guard let username = dictionary["username"] as? String else {return}
                guard let profileImageUrl = dictionary["profileImageUrl"] as? String else {return}
                guard let timestamp = dictionary["timestamp"] as? Timestamp else {return}
                guard let typeInt = dictionary["type"] else {return}
                guard let uid = dictionary["uid"] as? String else {return}
                let type = NotificationType(rawValue: typeInt as! Int)
                guard type != nil else {return}
                
                let notification = Notification(id: document.documentID, postId: postId ?? nil, username: username, profileImageUrl: profileImageUrl, timestamp: timestamp, type: type!, uid: uid)
                self.notifications.append(notification)
            }
        }
    }
    
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard uid != user.id else {return}
        
        var data: [String: Any] = [
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "uid": user.id ?? "",
            "profileImageUrl": user.profileImageUrl,
            "type": type.rawValue
        ]
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        Firestore.firestore()
            .collection("notifications").document(uid)
            .collection("user-notifications").addDocument(data: data)
    }
}
