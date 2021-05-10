//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel
    @State private var showPostImage = false
    
    var isFollowed: Bool {return viewModel.notificaiton.userIsFollowed ?? false}
    
    init(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            if let user = viewModel.notificaiton.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    KFImage(URL(string: viewModel.notificaiton.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text("\(viewModel.notificaiton.username): ").font(.system(size: 14, weight: .semibold)) +
                    Text(" \(viewModel.notificaiton.type.notifcationMessage)")
                        .font(.system(size: 15)) +
                        Text(" \(viewModel.timestampString)")
                        .font(.system(size: 12)).foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            if viewModel.notificaiton.type != .follow {
                if let post = viewModel.notificaiton.post {
                    NavigationLink(destination: FeedCell(viewModel: FeedCellViewModel(post: post))) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                }
            } else {
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .clipShape(Capsule())
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.blue, lineWidth: isFollowed ? 1 : 0)
                        )
                })
                .cornerRadius(3)
                .padding(.top)
            }
        }.padding(.horizontal)
    }
}

//struct NotificationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCell()
//    }
//}
