//
//  NotificationCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 10.05.2021.
//

import SwiftUI
import Firebase

class NotificationCellViewModel: ObservableObject {
    @Published var notificaiton: Notification
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notificaiton.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(notificationParam: Notification) {
        self.notificaiton = notificationParam
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    func follow() {
        UserService.follow(uid: notificaiton.uid) { _ in
            print("Successfully followed: \(self.notificaiton.username)")
            self.notificaiton.userIsFollowed = true
        
            NotificationsViewModel.uploadNotification(toUid: self.notificaiton.uid, type: .follow)
        }
    }
    
    func unfollow() {
        UserService.unfollow(uid: notificaiton.uid) { _ in
            print("Successfully unfollowed: \(self.notificaiton.username)")
            self.notificaiton.userIsFollowed = false
        }
    }

    func checkIfUserIsFollowed() {
        guard notificaiton.type == .follow else { return }
        UserService.checkIfUserIsFollowed(uid: notificaiton.uid) { isFollowed in
            self.notificaiton.userIsFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        guard let postId = notificaiton.postId else {return}
        Firebase.Firestore.firestore().collection("posts").document(postId).getDocument { snapshot, err in
            if err != nil {
                print("DEBUG: Error fetching post from notification: \(String(describing: err?.localizedDescription))")
                return
            }
            self.notificaiton.post = try? snapshot?.data(as: Post.self)
        }
    }
    
    func fetchNotificationUser() {
        Firebase.Firestore.firestore().collection("users").document(notificaiton.uid).getDocument { snapshot, err in
            if err != nil {
                print("DEBUG: Error fetching user from notification: \(String(describing: err?.localizedDescription))")
                return
            }
            self.notificaiton.user = try? snapshot?.data(as: User.self)
        }
    }
}
