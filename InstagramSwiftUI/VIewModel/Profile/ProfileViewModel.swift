//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import Foundation
import Firebase


class ProfileViewModel: ObservableObject {
    var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func follow() {
        print("follow invoked")
        guard let uid = user.id else {return}
        UserService.follow(uid: uid) { _ in
            print("Successfully followed: \(self.user.username)")
            self.user.isFollowed = true
        
            NotificationsViewModel.uploadNotification(toUid: uid, type: .follow)
        }
    }
    
    func unfollow() {
        guard let uid = user.id else {return}
        UserService.unfollow(uid: uid) { _ in
            print("Successfully unfollowed: \(self.user.username)")
            self.user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        guard !user.isCurrentUser else {return}
        guard let uid = user.id else {return}
        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        print("invoked fetchUserStats")
        guard let uid = user.id else {return}
        
//        print("uid fetchUserStats: ", uid)
        
        Firestore.firestore()
            .collection("following").document(uid)
            .collection("user-following").getDocuments { snapshot, err in
                guard let following = snapshot?.documents.count else {return}
                
//                print("following: ", following)
                
                Firestore.firestore()
                    .collection("followers").document(uid)
                    .collection("user-following").getDocuments { snapshot, err in
                        guard let followers = snapshot?.documents.count else {return}
                        
//                        print("followers: ", followers)

                        
                        Firestore.firestore()
                            .collection("posts")
                            .whereField("ownerId", isEqualTo: uid).getDocuments { snapshot, err in
                                guard let posts = snapshot?.documents.count else {return}
                                
//                                print("posts: ", posts)

                                
                                self.user.stats = UserStats(following: following, posts: posts, followers: followers)
                                print("stats: ", self.user.stats)
                            }
                    }
            }
    }
}
